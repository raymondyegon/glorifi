import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin MobileNumberControllerMixin on GetxController {
  final _mobileController = TextEditingController();

  TextEditingController get mobileController => _mobileController;

  bool get mobileValid {
    return _mobileController.text.replaceAll(RegExp('[^0-9]'), '').length == 10;
  }
}
