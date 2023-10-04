import 'package:get/instance_manager.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/processing/acc_processing_controller.dart';

class ACCProcessingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ACCProcessingController());
  }
}
