import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';

class UserNameController extends GetxController {

  final nameFormKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  TextEditingController get firstNameController => _firstNameController;

  final _middleNameController = TextEditingController();
  TextEditingController get middleNameController => _middleNameController;

  final _lastNameController = TextEditingController();
  TextEditingController get lastNameController => _lastNameController;

  final _dobController = TextEditingController();
  TextEditingController get dobController => _dobController;


  String? firstNameValidator(String value) {
    if (value.isEmpty) {
      return 'Invalid First Name';
    }
    return null;
  }

  String? lastNameValidator(String value) {
    if (value.isEmpty) {
      return 'Invalid Last Name';
    }
    return null;
  }

  void trySubmit() {
    final isValid = nameFormKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      Get.toNamed(Routes.investmentDOB);
      // User those values to send our request ...
    }
  }

  //Dispose all controllers to avoid memory leaks
  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
