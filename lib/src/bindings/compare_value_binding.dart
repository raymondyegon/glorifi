import 'package:get/get.dart';
import 'package:glorifi/src/controllers/comparison_feature_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class CompareValueBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<ComparisonFeatureController>(() => ComparisonFeatureController());
  }
}
