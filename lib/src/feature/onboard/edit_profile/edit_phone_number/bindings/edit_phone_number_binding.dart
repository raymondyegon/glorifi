import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_phone_number/controllers/edit_phone_number_controller.dart';

class EditPhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPhoneNumberController>(
      () => EditPhoneNumberController(),
    );
  }
}
