import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/services/authentication_service.dart';

mixin PhoneNumberControllerMixin on GetxController {
  final AuthenticationService authService = Get.find<AuthenticationService>();

  bool loading = false;

  TextEditingController get phoneNumberController => _phoneNumberController;
  final _phoneNumberController = TextEditingController();
  final phoneNumberOnlineValidationController = true.obs;

  bool get isphoneNumberCodeValid {
    return _phoneNumberController.text
            .replaceAll(RegExp('[^0-9]'), '')
            .length ==
        10;
  }


  RxBool havePhoneNumberError=false.obs;
  RxString  errorMessage="".obs;
}


