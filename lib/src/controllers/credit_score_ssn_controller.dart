import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/enable_credit_score_main_controller.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class CreditScoreSsnController extends BaseController {
  EnableCreditScoreController enableCreditScoreController = Get.find<EnableCreditScoreController>();
  var ssnController = TextEditingController();

  RxBool isButtonEnable = false.obs;
  RxBool isResultLoaded = false.obs;

  @override
  void onInit() {
    ssnController.text = enableCreditScoreController.enableCreditScoreModel.identity.governmentId.value ?? '';
    checkEnableButton();
    super.onInit();
  }

  checkEnableButton() {
    isButtonEnable(ssnController.text.trim().length == 11);
    enableCreditScoreController.enableCreditScoreModel.identity.governmentId.value = ssnController.text;
  }

  enableScoreApi() {
    Future.delayed(const Duration(seconds: 2), () {
      isResultLoaded.value = true;
    });
  }

  @override
  void onClose() {
    ssnController.dispose();

    super.onClose();
  }
}
