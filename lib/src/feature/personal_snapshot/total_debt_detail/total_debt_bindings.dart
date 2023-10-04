import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/total_debt_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class TotalDebtBindings extends BaseBinding {
  @override
  void dependencies() {
    Get.lazyPut<TotalDebtController>(() => TotalDebtController(), fenix: true);
  }
}
