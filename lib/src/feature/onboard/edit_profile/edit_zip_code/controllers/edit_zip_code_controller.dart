import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/zip_code_controller_mixin.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class EditZipCodeController extends GetxController with ZipCodeControllerMixin {
  ProfileController profileController = Get.find();

  RxBool haveZipCodeNameError=false.obs;
  RxString  errorMessage="".obs;


  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is String) {
      zipController.text = Get.arguments;
    }
    zipController.text = profileController.userProfile.zip;
  }

  Future<bool> updateZipCode() async {
    bool isSuccess = false;
    try {
      String zipCode = zipController.text;
      final response =
          await DataHelperImpl.instance.apiHelper.editZipCode(zipCode);
      response.fold(
        (l) {
          Log.error(l.toString());
        },
        (r) {
          if (r) {
            profileController.onZipCodeUpdateSuccess(zipCode);
            isSuccess = r;
          } else {
            showSnackBar("ZIP code cannot be updated. Try again later");
          }
        },
      );
    } catch (e) {
      Log.error(e.toString());
    }
    return isSuccess;
  }
}
