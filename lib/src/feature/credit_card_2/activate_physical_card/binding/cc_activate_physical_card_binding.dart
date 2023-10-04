import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/activate_physical_card/controller/cc_activate_physical_card_controller.dart';

class CCActivatePhysicalCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CCActivatePhysicalCardController());
  }
}
