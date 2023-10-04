import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/services/authentication_service.dart';

mixin ZipCodeControllerMixin on GetxController {
  final AuthenticationService authService = Get.find<AuthenticationService>();

  bool loading = false;

  TextEditingController get zipController => _zipController;
  final _zipController = TextEditingController();
  final zipOnlineValidationController = true.obs;

  bool get isZipCodeValid {
    return _isZipCodeValidLocal && zipOnlineValidationController.value;
  }

  bool get _isZipCodeValidLocal =>
      _zipController.text.isNumericOnly && (_zipController.text.length == 5);

  Future<bool?> isZipCodeValidByOnline() async {
    bool isValid = await authService.verifyZipCode(zipController.text);

    zipOnlineValidationController(isValid);

    return isValid;
  }
}
