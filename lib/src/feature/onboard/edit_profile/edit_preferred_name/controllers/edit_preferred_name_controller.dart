import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/preferred_name_controller_mixin.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class EditPreferredNameController extends GetxController
    with PreferredNameControllerMixin {
  ProfileController profileController = Get.find();

  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is String) {
      preferredNameController.text = Get.arguments;
    }
  }

  bool isPreferredNameValid() {
    if (preferredNameController.text.isEmpty) {
      return false;
    }
    if (!preferredNameValid) {
      return false;
    }
    return true;
  }

  Future<bool> updatePreferredName() async {
    bool isSuccess = false;
    try {
      String preferredName = preferredNameController.text;
      final response = await DataHelperImpl.instance.apiHelper
          .editPreferredName(preferredName);
      response.fold(
        (l) {
          Log.error(l.toString());
        },
        (r) {
          if (r) {
            profileController.onPreferredNameUpdateSuccess(preferredName);
            isSuccess = r;
          } else {
            showSnackBar("Preferred name cannot be updated. Try again later");
          }
        },
      );
    } catch (e) {
      Log.error(e.toString());
    }
    return isSuccess;
  }


  RxBool haveError=false.obs;
  RxString  errorMessage="".obs;
}
