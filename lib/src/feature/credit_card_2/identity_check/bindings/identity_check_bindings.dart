import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:glorifi/src/controllers/camera/glorifi_camera_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/controller/Identity_check_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class IdentityCheckBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.put<GloriFiCameraController>(GloriFiCameraController());
    Get.put<IdentityCheckController>(IdentityCheckController());
  }
}
