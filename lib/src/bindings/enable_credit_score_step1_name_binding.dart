import 'package:get/get.dart';
import 'package:glorifi/src/controllers/enable_credit_score_main_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/controllers/edit_profile_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class EnableCreditScoreStep1NameBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<EnableCreditScoreController>(
        () => EnableCreditScoreController());
  }
}
