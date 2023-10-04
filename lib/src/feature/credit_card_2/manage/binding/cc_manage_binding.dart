import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/controller/cc_manage_controller.dart';

class CCManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CCManageController(), fenix: true);
  }
}