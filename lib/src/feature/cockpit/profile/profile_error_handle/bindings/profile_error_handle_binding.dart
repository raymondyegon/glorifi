import 'package:get/get.dart';

import '../controllers/profile_error_handle_controller.dart';

class ProfileErrorHandleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileErrorHandleController>(
      () => ProfileErrorHandleController(),
    );
  }
}
