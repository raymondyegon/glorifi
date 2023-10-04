import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/member_application_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/service/acc_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class ExpenseController extends BaseController {
  final ACCService _accService = Get.find<ACCService>();
  final ACCController accController = Get.find<ACCController>();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);

  get pageState => _pageStateController.value;

  /// Selected Accommodation
  late String _selectedAccommodation;

  setSelectedAccommodationType(String selectedAccommodationType) {
    _selectedAccommodation = selectedAccommodationType;
  }

  List<String> accommodationTypes = [
    TextConstants.own,
    TextConstants.rent,
    TextConstants.other
  ];

  /// From DESERVE documentation
  /// Expected [housing_type] is the following:
  /// "OWN", "RENTED", "OTHER"
  String _getAPIFriendlyAccommodationType() {
    if (_selectedAccommodation == accommodationTypes[0]) {
      return "OWN";
    } else if (_selectedAccommodation == accommodationTypes[1]) {
      return "RENTED";
    } else {
      return "OTHER";
    }
  }

  String _getFormattedExpense() {
    return expensesController.text.replaceAll(r'$', '').replaceAll(',', '');
  }

  validateExpenseInformation() async {
    if (accController.isMockEnabled) {
      _populateFinancialData();

      _pageStateController(PageState.SUCCESS);
    } else {
      Map<String, dynamic> data = {
        "expenses": _getFormattedExpense(),
        "housing_type": _getAPIFriendlyAccommodationType(),
      };
      try {
        _pageStateController(PageState.LOADING);
        await _accService.validateExpenseInformation(data);
        _populateFinancialData();
        _pageStateController(PageState.SUCCESS);
      } catch (e) {
        _pageStateController(PageState.ERROR);

        /// TODO: Implement proper error message parsing
        showErrorToast("Something went wrong");
      }
    }
  }

  /// Populate ACCMemberModel Financial Data
  void _populateFinancialData() {
    try {
      Get.find<ACCMemberApplicationModel>().financialInfo =
          Get.find<ACCMemberApplicationModel>().financialInfo!.copyWith(
                expenses: int.tryParse(_getFormattedExpense()),
                housingType: _getAPIFriendlyAccommodationType(),
              );
      Log.debug(Get.find<ACCMemberApplicationModel>().toJson());
    } on Exception catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      showErrorToast("Something went wrong");
    }
  }

  /// Text editing controllers
  final TextEditingController expensesController = TextEditingController();
}
