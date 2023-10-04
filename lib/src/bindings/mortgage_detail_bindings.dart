import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

import '../feature/mortgage/controllers/mortgage_detail_controller.dart';

class MortgageDetailBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<MortgageDetailController>(() => MortgageDetailController());
  }
}
