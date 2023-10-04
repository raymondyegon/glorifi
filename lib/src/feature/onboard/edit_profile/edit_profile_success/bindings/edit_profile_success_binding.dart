import 'package:get/get.dart';

import '../controllers/edit_profile_success_controller.dart';

class EditProfileSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileSuccessController>(
      () => EditProfileSuccessController(),
    );
  }
}
