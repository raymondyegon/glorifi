import 'package:get/instance_manager.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/application_status_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/member_application_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/card_holder_agreement/controller/acc_agreement_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/controller/kyc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/review_application/acc_review_application_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/service/acc_service.dart';

class ACCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ACCService());
    Get.lazyPut(() => ACCController());
    Get.lazyPut(() => KYCController());
    Get.lazyPut(() => ACCReviewApplicationController(), fenix: true);
    Get.lazyPut(() => ACCReviewApplicationController(),fenix: true);
    Get.lazyPut(() => ACCAgreementController());
    Get.lazyPut(() => ACCMemberApplicationModel());
    Get.lazyPut(() => ACCApplicationStatusModel());
  }
}
