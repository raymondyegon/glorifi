import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/enable_credit_score_main_controller.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class CreditScorePhoneNoController extends BaseController {
  EnableCreditScoreController creditScoreDetailsController = Get.find<EnableCreditScoreController>();
  String originalNumber = '';
  Rx<String> pin = ''.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> disableBackButtonIfDialogIsVisible = false.obs;

  var phoneNoController = TextEditingController();

  RxBool isButtonEnable = false.obs;
  RxBool isResultLoaded = false.obs;

  @override
  void onInit() {
    originalNumber = creditScoreDetailsController.enableCreditScoreModel.identity.phone.first.number!;
    if (originalNumber.length == 10) {
      originalNumber = originalNumber.substring(0, 3) + "-" + originalNumber.substring(3, 6) + "-" + originalNumber.substring(6, originalNumber.length);
    }
    phoneNoController.text = originalNumber;
    checkEnableButton();
    super.onInit();
  }

  checkEnableButton() {
    creditScoreDetailsController.enableCreditScoreModel.identity.phone.first.number = phoneNoController.text;
    isButtonEnable.value = phoneNoController.text.trim().isNotEmpty && phoneNoController.text.length == 12;
  }

  enableScoreApi() {
    Future.delayed(const Duration(seconds: 2), () {
      isResultLoaded.value = true;
    });
  }

  @override
  void onClose() {
    phoneNoController.dispose();
    super.onClose();
  }
}
