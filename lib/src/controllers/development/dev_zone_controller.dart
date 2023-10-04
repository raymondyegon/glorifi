import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class DevZoneController extends BaseController {
  //Declare all the late initialize variables here
  String currentScreen = 'DevZone';
  @override
  void onInit() {
    super.onInit();
    debugPrint(currentScreen);
  }

  @override
  void onReady() {}

  @override
  void update([List<Object>? ids, bool condition = true]) {}

  @override
  void onClose() {}

  void navigateToCreateProfile() {
    Get.toNamed(Routes.createProfile);
  }

  void navigateToCreateProfilePlus() {
    Get.toNamed(Routes.createProfilePlus);
  }

  void navigateToNavBarScreen() {
    Get.toNamed(Routes.cockpit);
  }

  void navigateToSampleSliver() {
    Get.toNamed(Routes.sample_sliver);
  }
}
