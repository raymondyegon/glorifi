import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class CreateAccountController extends BaseController {
  var firstN = "".obs;
  var lastN = "".obs;
  var birthday = "".obs;
  var zipcode = "".obs;
  var fNameController = TextEditingController().obs;
  var lastNController = TextEditingController().obs;
  var birthdayController = TextEditingController().obs;
  var zipcodeController = TextEditingController().obs;

  @override
  void onInit() {
    fNameController.value.text = firstN.value;
    lastNController.value.text = lastN.value;
    birthdayController.value.text = birthday.value;
    zipcodeController.value.text = zipcode.value;
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<TextEditingController>();
    super.onClose();
  }

  // whenever these setMethods will be called it will take the value and
  // update everywhere where ever we are using the respective controller.
  setFirstName(String firstName) {
    firstN.value = firstName;
  }

  setLastName(String lastName) {
    lastN.value = lastName;
  }

  setBirthday(String birth) {
    birthday.value = birth;
  }

  setZipcode(String zip) {
    zipcode.value = zip;
  }

  void navigateToSecondPage() {
    Get.toNamed(Routes.secondpage);
  }
}
