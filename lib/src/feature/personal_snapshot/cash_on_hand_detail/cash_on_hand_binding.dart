import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail/cash_on_hand_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class CashOnHandBinding extends BaseBinding {
  @override
  void dependencies() {
    Get.lazyPut<CashOnHandControllerV1>(() => CashOnHandControllerV1(),
        fenix: true);
  }
}
