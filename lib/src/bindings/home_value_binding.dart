
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/home_value_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class HomeValueBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<HomeValueController>(() => HomeValueController());
  }
}