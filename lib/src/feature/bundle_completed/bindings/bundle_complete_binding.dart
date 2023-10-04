import 'package:get/get.dart';
import 'package:glorifi/src/feature/bundle_completed/controllers/bundle_complete_controller.dart';

class BundleCompleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BundleCompleteController>(
      () => BundleCompleteController(),
    );
  }
}
