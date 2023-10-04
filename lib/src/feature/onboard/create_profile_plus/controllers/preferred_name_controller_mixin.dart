import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin PreferredNameControllerMixin on GetxController {
  final _prefNameController = TextEditingController();

  TextEditingController get preferredNameController => _prefNameController;

  bool get preferredNameValid {
    // final pattern = r"(^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]*$)";
    // RegExp regex = RegExp(pattern);
    // if (preferredNameController.text.isNotEmpty &&
    //     !regex.hasMatch(preferredNameController.text))
    //   return false;
    // else
    if (preferredNameController.text.startsWith(" ")) {
      return false;
    } else
      return true;
  }

  RxBool havePreferredNameError=false.obs;
  RxString  errorMessage="".obs;
}
