import 'package:get/instance_manager.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_service.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_service.dart';

class EBSServicingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EBSService());
  }
}
