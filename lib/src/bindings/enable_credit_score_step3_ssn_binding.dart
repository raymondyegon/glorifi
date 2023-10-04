import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_ssn_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class EnableCreditScoreStep3SSNBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<CreditScoreSsnController>(() => CreditScoreSsnController());
  }
}
