import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/enable_credit_score_main_controller.dart';
import 'package:glorifi/src/model/address_autocomplete/place_detail_model.dart';
import 'package:glorifi/src/model/personal_snapshot/enable_credit_score_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:us_states/us_states.dart';

class CreditScoreEnableAddressController extends BaseController {
  EnableCreditScoreController creditScoreDetailsController =
      Get.find<EnableCreditScoreController>();

  var streetAddressController = TextEditingController();
  var suiteController = TextEditingController();
  var cityController = TextEditingController();
  var zipCodeController = TextEditingController();
  RxString selectedState = ''.obs;

  RxBool isButtonEnable = false.obs;
  RxBool isResultLoaded = false.obs;

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  void _loadData() {
    EnableCreditScoreModel _data =
        creditScoreDetailsController.enableCreditScoreModel;
    streetAddressController.text =
        _data.identity.address.first.addressLine1 ?? '';
    suiteController.text = _data.identity.address.first.addressLine2 ?? '';
    cityController.text = _data.identity.address.first.city ?? '';
    zipCodeController.text = _data.identity.address.first.postalCode ?? '';
    selectedState.value = _data.identity.address.first.regionFullName ?? '';
    checkEnableButton();
  }

  checkEnableButton() {
    isButtonEnable.value = streetAddressController.text.trim().isNotEmpty &&
        cityController.text.trim().isNotEmpty &&
        zipCodeController.text.trim().isNotEmpty &&
        selectedState.isNotEmpty;
    saveData();
  }

  void saveData() {
    creditScoreDetailsController.enableCreditScoreModel.identity.address.first
        .addressLine1 = streetAddressController.text;
    creditScoreDetailsController.enableCreditScoreModel.identity.address.first
        .addressLine2 = suiteController.text;
    creditScoreDetailsController.enableCreditScoreModel.identity.address.first
        .city = cityController.text;
    creditScoreDetailsController.enableCreditScoreModel.identity.address.first
        .postalCode = zipCodeController.text;
    creditScoreDetailsController.enableCreditScoreModel.identity.address.first
        .regionFullName = selectedState.value;
    creditScoreDetailsController.enableCreditScoreModel.identity.address.first
        .region = USStates.getAbbreviation(selectedState.value);
  }

  void fillAddressForm(PlaceDetailModel place) {
    streetAddressController.text =
        '${place.streetNumber != '' ? '${place.streetNumber} ' : ''}${place.route}';
    cityController.text = place.city;
    zipCodeController.text = place.zipCode;
    selectedState.value = place.state;
    checkEnableButton();
  }

  enableScoreApi() {
    Future.delayed(const Duration(seconds: 2), () {
      isResultLoaded.value = true;
    });
  }

  @override
  void onClose() {
    streetAddressController.dispose();
    suiteController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }
}
