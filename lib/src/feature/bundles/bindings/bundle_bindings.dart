import 'package:get/get.dart';
import 'package:glorifi/src/feature/bundles/controller/bundle_controller.dart';

class BundleBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BundleController(), tag: BundleController.bundleScreenTag);
  }
}
