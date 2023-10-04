import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/value/controller/value_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class ValueBindings extends BaseBinding {
  @override
  void dependencies() {
    Get.lazyPut<ValueController>(() => ValueController());
  }
}
