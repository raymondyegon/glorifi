import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:glorifi/src/feature/investment/controller/signup_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class SignUpBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
