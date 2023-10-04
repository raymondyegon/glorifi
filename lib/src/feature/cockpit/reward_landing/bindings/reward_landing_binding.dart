import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';

import '../controllers/reward_landing_controller.dart';

class RewardLandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RewardLandingController>(
      () => RewardLandingController(),
    );
    Get.lazyPut<LoyaltyController>(
      () => LoyaltyController(),
    );
  }
}
