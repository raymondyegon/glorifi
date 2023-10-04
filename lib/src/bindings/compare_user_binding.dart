
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/compare_user_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class CompareUserBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<CompareUserController>(() => CompareUserController());
  }
}