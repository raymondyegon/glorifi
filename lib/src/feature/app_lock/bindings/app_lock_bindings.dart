
import 'package:get/get.dart';
import 'package:glorifi/src/feature/app_lock/controllers/app_lock_controller.dart';

class AppLockBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppLockController());
  }
}