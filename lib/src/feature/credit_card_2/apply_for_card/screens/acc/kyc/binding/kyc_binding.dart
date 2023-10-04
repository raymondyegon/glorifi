import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/employment_status/controller/employment_status_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/controller/kyc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/processing/acc_processing_controller.dart';

class KYCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KYCController());
    Get.lazyPut(() => ACCProcessingController());
    Get.lazyPut(() => EmploymentStatusController(), fenix: true);
  }
}
