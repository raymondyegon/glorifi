import 'package:get/instance_manager.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_service.dart';

class OpenBankAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OAOController());
    Get.lazyPut(() => OAOService());
  }
}
