import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class TextFiledWidgetController extends BaseController {
  TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    change('newState',status: RxStatus.success());
    super.onInit();
  }


  @override
  void onClose() {
    // TODO: implement onClose
    textEditingController.dispose();
    super.onClose();
  }
}
