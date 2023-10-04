import 'package:get/get.dart';

import '../controllers/communications_controller.dart';

class CommunicationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunicationsController>(
      () => CommunicationsController(),
    );
  }
}
