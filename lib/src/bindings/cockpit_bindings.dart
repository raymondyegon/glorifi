import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:glorifi/src/controllers/DeveloperOptionsController.dart';
import 'package:glorifi/src/controllers/image_picker_controller.dart';
import 'package:glorifi/src/controllers/member_controller.dart';
import 'package:glorifi/src/controllers/notification_controller.dart';
import 'package:glorifi/src/controllers/permission_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/cockpit/controllers/cockpit_controller.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/greeting/weather_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_controller.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/controllers/reward_landing_controller.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_controller.dart';
import 'package:glorifi/src/services/rewards_service.dart';

class CockpitBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CockpitController>(() => CockpitController());
    Get.lazyPut<InsightsController>(() => InsightsController());
    Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);
    Get.lazyPut<ImagePickerController>(() => ImagePickerController(), fenix: true);
    Get.lazyPut<CarouselController>(() => CarouselController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.put(WeatherController());
    Get.put(MemberController());
    Get.lazyPut(() => RewardLandingController(), fenix: true);
    Get.lazyPut(() => LoyaltyController(), fenix: true);
    Get.lazyPut(() => RewardsService());
    if (!kIsWeb) {
      Get.put(PermissionController());
    }
    
    Get.lazyPut<DeveloperOptionsController>(() => DeveloperOptionsController(), fenix: true);
    Get.lazyPut(() => FeatureFlagController());
  }
}
