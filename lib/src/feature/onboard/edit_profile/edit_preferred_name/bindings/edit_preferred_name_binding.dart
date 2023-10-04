import 'package:get/get.dart';

import '../controllers/edit_preferred_name_controller.dart';

class EditPreferredNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPreferredNameController>(
      () => EditPreferredNameController(),
    );
  }
}
