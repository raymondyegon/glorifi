import 'package:get/get.dart';

class EditProfileSuccessController extends GetxController {
  final _titleController = "Profile".obs;

  String get title => _titleController.value;

  String get message =>
      "Success!\nYour ${_titleController.value} has been changed";

  @override
  void onInit() {
    if (Get.arguments is String) {
      _titleController(Get.arguments);
    }
    super.onInit();
  }
}
