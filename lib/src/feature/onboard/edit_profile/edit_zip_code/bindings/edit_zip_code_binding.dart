import 'package:get/get.dart';

import '../controllers/edit_zip_code_controller.dart';

class EditZipCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditZipCodeController>(
      () => EditZipCodeController(),
    );
  }
}
