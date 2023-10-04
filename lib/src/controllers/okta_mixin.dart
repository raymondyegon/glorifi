import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/dynamic_link_module.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/utils/okta_flutter_bridge.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

mixin OktaMixin on GetxController {
  final SessionManagerService _sessionManagerService =
      Get.find<SessionManagerService>();

  loginUsingOkta(String email,
      {Function()? onLoginSuccess,
      Function(String error)? onLoginError, bool isNewAccount = false}) async {
    // ** Leaving this commented to clarity.
    // We a user using Okta for authentication must be independent of Local biometric. Otherwise, denying local biometrics will prevent
    // me from tapping the Sign In  button on the Login screen if I have not allowed local bio during account creation

    // bool _localAuthFlag = await LocalAuth.checkDeviceIfHasLocalBio();
    // if (!_localAuthFlag) {
    //   showErrorToast("FaceID hasn't setup properly on your device!");
    //   return;
    // }

    try {
      final oktaCreated = await OktaFlutterBridge.initOkta();
      // Some sort of race condition. I deeply regret writing this line of code
      await Future.delayed(Duration(seconds: 1));
      if (oktaCreated == 'true') {
        final tokensResponse = await OktaFlutterBridge.authenticate(email, isNewAccount);
        if (tokensResponse['access'] != null &&
            tokensResponse['refresh'] != null) {
          await _sessionManagerService.onLoginSuccess(
              tokensResponse['access'], tokensResponse['refresh']);

          await DataHelperImpl.instance.cacheHelper.saveUserEmail(email);

          if (onLoginSuccess != null) {
            onLoginSuccess();
          } else {
            Get.offAllNamed(Routes.cockpit);
            if(DynamicLinkModule.instance.hasPendingLink){
              DynamicLinkModule.instance.redirectPendingLink!();
            }
          }
        } else {
          Log.error(tokensResponse['error']);

          bool userCancelledTheFlow = tokensResponse['error']
                  ?.toString()
                  .toLowerCase()
                  .contains("cancel") ==
              true;

          if (!userCancelledTheFlow) {
            String msg = "We can't find your account.";
            if(onLoginError != null){
              onLoginError(msg);
            } else {
              showSnackBar(msg);
            }
          }
        }
      } else {
        String msg = "Error creating okta";
        if(onLoginError != null){
          onLoginError(msg);
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              title: 'Error creating okta',
            ),
          );
        }
      }
    } catch (e) {
      Log.error(e.toString());
      String msg = "Something went wrong! Try again later.";
      if(onLoginError != null){
        onLoginError(msg);
      } else {
        showSnackBar(msg);
      }
    }
  }
}
