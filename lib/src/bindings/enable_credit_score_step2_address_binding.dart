import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_enable_address_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class EnableCreditScoreStep2AddressBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<CreditScoreEnableAddressController>(
      () => CreditScoreEnableAddressController(),
    );
  }
}
