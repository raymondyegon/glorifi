import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/login/controllers/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
