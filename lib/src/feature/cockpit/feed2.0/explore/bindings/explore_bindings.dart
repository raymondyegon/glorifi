import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/controller/explore_controller.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreController>(() => ExploreController());
  }
}
