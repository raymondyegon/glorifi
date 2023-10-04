import 'package:get/get.dart';

import '../controllers/unsafe_device_detected_controller.dart';

class UnsafeDeviceDetectedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnsafeDeviceDetectedController>(
      () => UnsafeDeviceDetectedController(),
    );
  }
}
