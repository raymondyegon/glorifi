import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/deposit_check_camera_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class DepositCheckCameraBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<DepositCheckCameraController>(
        () => DepositCheckCameraController());
  }
}
