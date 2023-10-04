import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class SavingsRetirementBindings extends BaseBinding {
  @override
  void dependencies() {
    Get.lazyPut<RetirementController>(() => RetirementController(),
        fenix: true);
  }
}
