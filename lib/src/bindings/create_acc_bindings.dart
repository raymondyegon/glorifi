import 'package:get/get.dart';
import 'package:glorifi/src/controllers/create_acc_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class CreateAccountBindings extends BaseBinding {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountController>(()=>CreateAccountController(),fenix: true);
  }
}