import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:glorifi/src/feature/credit_card/controller/credit_card_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class CreditCardBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<CreditCardController>(() => CreditCardController());
  }
}
