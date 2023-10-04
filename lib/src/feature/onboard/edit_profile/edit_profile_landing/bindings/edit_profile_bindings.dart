import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_phone_number/controllers/edit_phone_number_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_preferred_name/controllers/edit_preferred_name_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/controllers/edit_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_zip_code/controllers/edit_zip_code_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<EditPhoneNumberController>(() => EditPhoneNumberController());
    Get.lazyPut<EditZipCodeController>(() => EditZipCodeController());
    Get.lazyPut<EditPreferredNameController>(() => EditPreferredNameController());
    // Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    //  Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
