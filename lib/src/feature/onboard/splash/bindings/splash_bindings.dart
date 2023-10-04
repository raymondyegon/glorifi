import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/splash/controllers/splash_controller.dart';
import 'package:glorifi/src/feature/update_handler/controllers/update_handler_controllers.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class SplashBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<UpdateHandlerControllers>(() => UpdateHandlerControllers());
  }
}
