import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class GlorifiGradientProgressIndicatorController extends BaseController
    with GetTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Rx<AnimationController> _animationRotationController;

  @override
  void onInit() {
    super.onInit();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animationRotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    ).obs;

    _animationController.addListener(() {
      _animationRotationController.refresh();
      if (_animationController.isCompleted) {
        _animationRotationController.value.repeat();
      }
    });

    _animationController.forward();
  }

  @override
  void onClose() {
    _animationController.dispose();
    _animationRotationController.value.dispose();
    super.dispose();
  }

  AnimationController get animationController => _animationController;
  AnimationController get animationRotationController =>
      _animationRotationController.value;
}
