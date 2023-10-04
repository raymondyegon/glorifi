import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/net_worth_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class NetWorthBindings extends BaseBinding {
  @override
  void dependencies() {
    Get.lazyPut<NetWorthController>(() => NetWorthController());
  }
}
