import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:glorifi/src/controllers/on_boarding_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class OnBoardingBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }
}
