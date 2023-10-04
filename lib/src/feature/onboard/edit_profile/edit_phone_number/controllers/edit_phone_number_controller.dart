import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/phone_number_controller_mixin.dart';
import 'package:glorifi/src/services/authentication_service.dart';

class EditPhoneNumberController extends GetxController
    with PhoneNumberControllerMixin {
  ProfileController profileController = Get.find();
  final AuthenticationService authService = Get.find<AuthenticationService>();

  RxBool haveError=false.obs;
  RxString  errorMessage="".obs;



  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is String) {
      phoneNumberController.text = Get.arguments;
    }
  }

  Future<bool> editPhoneNumber(String _mobileNumber) async {
    bool isSuccess = false;
    try {
      var respones = await authService.editPhoneNumber(_mobileNumber);
      Log.info(respones["success"]);
      isSuccess = respones["success"];
    } catch (e) {
      Log.error(e.toString());
    }
    return isSuccess;
  }

  Future sentOtpPhone() async {
    try {
      var respones = await authService.sentOtpPhone();

      return respones;
    } catch (e) {
      Log.error(e.toString());
    }
  }
}
