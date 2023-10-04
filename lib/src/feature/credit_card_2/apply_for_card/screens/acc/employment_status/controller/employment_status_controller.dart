import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/member_application_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/service/acc_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

/// Uses KYCBinding
class EmploymentStatusController extends BaseController {
  final ACCService _accService = Get.find<ACCService>();
  final ACCController accController = Get.find<ACCController>();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);

  get pageState => _pageStateController.value;

  /// Selected Employment Status
  String? _selectedEmploymentStatus;

  set setSelectedEmploymentStatus(value) => _selectedEmploymentStatus = value;

  String get getSelectedEmploymentStatus => _selectedEmploymentStatus as String;

  /// Employment status options
  List<String> employmentStatusOptions = [
    "Full-Time",
    "Part-Time",
    "Self-employed",
    "Other (Retired, Student, or unemployed)",
  ];

  /// From DESERVE documentation
  /// Expected [employment_status] is the following:
  /// "EMPLOYED_FULL_TIME" "EMPLOYED_PART_TIME" "RETIRED"
  /// "SELF_EMPLOYED" "COLLEGE_STUDENT" "UNEMPLOYED" "OTHER"
  String _getAPIFriendlyEmploymentStatus() {
    if (_selectedEmploymentStatus == employmentStatusOptions[0]) {
      return "EMPLOYED_FULL_TIME";
    } else if (_selectedEmploymentStatus == employmentStatusOptions[1]) {
      return "EMPLOYED_PART_TIME";
    } else if (_selectedEmploymentStatus == employmentStatusOptions[2]) {
      return "SELF_EMPLOYED";
    } else {
      return "OTHER";
    }
  }

  /// [source_of_income] field needs to be updated based on what
  /// user selects as their [employment_status].
  /// If [employment_status] is among these three ([EMPLOYED_FULL_TIME],
  /// [EMPLOYED_PART_TIME], [SELF_EMPLOYED]), then [source_of_income] should be
  /// [EMPLOYMENT]. Else it should be [OTHER] of everything else.
  /// NOTE: This might change later.
  String _updateSourceOfIncomeField() {
    if (_selectedEmploymentStatus == employmentStatusOptions.last) {
      return "OTHER";
    } else {
      return "EMPLOYMENT";
    }
  }

  /// According to DESERVE [income_type] can be either
  /// [MONTHLY_INCOME] or [YEARLY_INCOME]
  /// For now we will send [YEARLY_INCOME] but might change later.
  String _getIncomeType() {
    return "YEARLY_INCOME";
  }

  String _getFormattedIncome() {
    return annualIncomeController.text.replaceAll(r'$', '').replaceAll(',', '');
  }

  /// Validate Employment Status
  Future<void> validateEmploymentStatus() async {
    if (accController.isMockEnabled) {
      _populateFinancialData();
      _pageStateController(PageState.SUCCESS);
    } else {
      Map<String, dynamic> data = {
        "employment_status": _getAPIFriendlyEmploymentStatus(),
        "income": _getFormattedIncome(),
        "source_of_income": _updateSourceOfIncomeField(),
        "income_type": _getIncomeType(),
      };
      try {
        _pageStateController(PageState.LOADING);
        await _accService.validateEmploymentStatus(data);
        _populateFinancialData();
        _pageStateController(PageState.SUCCESS);
      } catch (e, stackTrace) {
        Log.error(e.toString());
        Log.error(stackTrace.toString());
        showErrorToast("Something went wrong");
        _pageStateController(PageState.ERROR);
      }
    }
  }

  /// Populate ACCMemberModel Financial Data
  void _populateFinancialData() {
    try {
      Get.find<ACCMemberApplicationModel>().financialInfo = FinancialInfo(
        employmentStatus: _getAPIFriendlyEmploymentStatus(),
        sourceOfIncome: _updateSourceOfIncomeField(),
        incomeType: _getIncomeType(),
        income: int.parse(_getFormattedIncome()),
      );
      Log.debug(Get.find<ACCMemberApplicationModel>().toJson());
    } on Exception catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      showErrorToast("Something went wrong");
    }
  }

  /// Text Editing Controllers
  final TextEditingController annualIncomeController = TextEditingController();
}
