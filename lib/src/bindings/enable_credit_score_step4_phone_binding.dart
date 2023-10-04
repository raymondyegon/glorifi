import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_phoneno_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class EnableCreditScoreStep4PhoneBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<CreditScorePhoneNoController>(
        () => CreditScorePhoneNoController());
  }
}
