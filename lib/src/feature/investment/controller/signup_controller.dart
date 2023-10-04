import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';

class SignUpController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  String? emailValidator(String value) {
    if (value.isEmpty || !value.isEmail) {
      return 'Invalid Email';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Invalid Password';
    } else if (!validatePassword(value)) {
      return 'Invalid Password';
    }
    return null;
  }

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void trySubmit() {
    final isValid = loginFormKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      Get.toNamed(Routes.getStarted);
      // User those values to send our request ...
    }
  }

  //Dispose all controllers to avoid memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
