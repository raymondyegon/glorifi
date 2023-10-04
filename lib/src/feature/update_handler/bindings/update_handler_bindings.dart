import 'package:get/get.dart';
import 'package:glorifi/src/feature/update_handler/controllers/update_handler_controllers.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class UpdateHandlerBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<UpdateHandlerControllers>(() => UpdateHandlerControllers());
  }
}
