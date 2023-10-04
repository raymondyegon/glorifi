import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:intl/intl.dart';

import '../core/data_helper.dart';
import '../core/exceptions/custom_exception.dart';
import '../feature/personal_snapshot/compare/compare_value.dart';
import '../model/comparison_model.dart';

class ComparisonFeatureController extends BaseController {
  GloriFiCompareType gloriFiCompareType = GloriFiCompareType.netWorth;
  RxBool isEditing = false.obs;

  TextEditingController cityController = TextEditingController();
  String selectMaritalStatus = 'Single';
  RxnString selectedState = RxnString();
  var maritalStatus = ['Single', 'Married'];
  RxString filterData = ''.obs;
  RxBool loading = false.obs;
  RxBool noDataForMember = false.obs;

  RxString memberAmount = ''.obs;
  RxString comparisonAmount = ''.obs;
  RxString member = ''.obs;
  RxString ageRange = ''.obs;

  var error = "".obs;

  GloriFiCompareType? compareState;

  final _dataHelper = DataHelperImpl.instance;

  saveComparison() {
    //save date to edit comparison api
    editComparison().then((success) {
      if (success == true) {
        getComparison();
      }
    });
  }

  Future<void> getComparison() async {
    final ProfileController _profileController = Get.find<ProfileController>();
    final DateTime _birthDate = _profileController.userProfile.birthDate;
    final int _age = DateTime.now().year - _birthDate.year;
    ageRange.value = '${_age - 4}-${_age + 4}';

    loading.value = true;

    final response = await _dataHelper.apiHelper.getComparison();
    response.fold((error) {
      apiExceptionMessage(error.errorCode, toast: true);

      change(setError(error), status: RxStatus.error());
    }, (success) => change(setComparisonModel(success), status: RxStatus.success()));

    loading.value = false;
    isEditing.value = false;
  }

  setComparisonModel(ComparisonModel model) {
    ComparisonItemData? _data;
    noDataForMember.value = false;
    switch (gloriFiCompareType) {
      case GloriFiCompareType.homeValue:
        if (model.data?.homeValue != null) {
          _data = model.data!.homeValue;
        } else {
          Log.error('Missing comparison homeValue data');
          loading.value = false;
        }
        break;
      case GloriFiCompareType.netWorth:
        if (model.data?.netWorth != null) {

          _data = model.data!.netWorth;
        } else {
          Log.error('Missing comparison networth data');
          loading.value = false;
        }
        break;
      default:
        Log.error('Invalid comparison data type');
    }
    memberAmount = compareState == GloriFiCompareType.creditScore
        ? member
        : NumberFormat.currency(name: '', symbol: r'$', decimalDigits: 0)
            .format(double.parse(member.value != 'null' ? member.value : '0').toInt())
            .obs;

    if (_data != null) {
      filterData.value =
          '${_data.comparisonData?.city}, ${_data.comparisonData?.state}, ${_data.comparisonData?.martialStatus} person, \nwithin your age range:';
      comparisonAmount = NumberFormat.currency(name: '', symbol: '', decimalDigits: 0)
          .format(double.parse(_data.comparison).toInt())
          .obs;

      cityController.text = _data.comparisonData?.city ?? "";
      selectedState.value = _data.comparisonData?.state;
      selectMaritalStatus = _data.comparisonData?.martialStatus ?? "Single";
      ageRange.value = _data.comparisonData?.ageRange ?? '';
    } else {
      if (model.data?.message == 'No comparison records found for the member') {
        noDataForMember.value = true;
      } else {
        showErrorToast('There was an unexpected error, please try again later.');
      }
    }
    loading.value = false;
  }

  setError(CustomException error) {
    this.error.value = error.errorMessage;
  }

  Future<bool> editComparison() async {
    loading.value = true;
    var map = Map<String, dynamic>();
    map['marital_status'] = selectMaritalStatus == "Single" ? 0 : 1;
    map['city'] = cityController.value.text;
    map['state'] = selectedState.value;
    final response = await _dataHelper.apiHelper.editComparison(map);
    loading.value = false;
    return response.fold((error) {
      if (error.errorCode == 437) {
        var _errorMessage = jsonDecode(error.errorMessage)['data']['message'];
        showErrorToast(_errorMessage);
      } else {
        apiExceptionMessage(error.errorCode, toast: true);
      }
      return false;
    }, (success) => true);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
