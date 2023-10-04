import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_usage_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class CreditUsageBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<CreditUsageController>(() => CreditUsageController());
  }
}
