import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class MenuNavigationController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late AnimationController drawerSlideController;

  @override
  void onInit() {
    super.onInit();

    drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    drawerSlideController.dispose();
    super.dispose();
  }

  bool isDrawerOpen() {
    return drawerSlideController.value == 1.0;
  }

  bool isDrawerOpening() {
    return drawerSlideController.status == AnimationStatus.forward;
  }

  bool isDrawerClosed() {
    return drawerSlideController.value == 0.0;
  }

  void toggleDrawer() {
    if (isDrawerOpen() || isDrawerOpening()) {
      drawerSlideController.reverse();
    } else {
      drawerSlideController.forward();
    }
  }
}
