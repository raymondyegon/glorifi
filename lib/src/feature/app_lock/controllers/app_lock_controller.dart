import 'package:get/get.dart';
import 'package:glorifi/src/controllers/biometric_auth_mixin.dart';
import 'package:glorifi/src/controllers/local_auth_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/dynamic_link_module.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/model/biometric_config.dart';
import 'package:glorifi/src/feature/onboard/login/models/login_args.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/session_manager_service.dart';

class AppLockController extends GetxController with BiometricAuthMixin {
  final SessionManagerService _sessionManagerService =
      Get.find<SessionManagerService>();

  final _biometricAssetController = "assets/images/ic_fingerprint_id.svg".obs;

  String get biometricAsset => _biometricAssetController.value;

  final _biometricTitleController = "".obs;

  String get biometricTitle => _biometricTitleController.value;

  final pageState = PageState.DEFAULT.obs;

  @override
  void onInit() {
    initResources();
    super.onInit();
  }

  initResources() async {
    var _bioType = await LocalAuth.getAvailableBiometrics();

    var biometricConfig = BiometricConfig(_bioType);

    Log.info("Type $_bioType");

    _biometricAssetController(biometricConfig.iconPath);
    _biometricTitleController(biometricConfig.buttonTitle);

    // After we present the screen, automatically prompt to save the user a tap
    onTapBioMetricButton();
  }

  onTapBioMetricButton() async {
    await loginUsingBiometric(
      onLoginSuccess: _onLoginSuccess,
      onLoginError: _onLoginError,
      onTokenExchangeStart: () => pageState(PageState.LOADING),
      onTokenExchangeDone: () => pageState(PageState.DEFAULT),
    );
  }

  _onLoginSuccess(dynamic tokenResponse) async {
    await _sessionManagerService.onLoginSuccess(
      tokenResponse['access_token'],
      tokenResponse['refresh_token'],
    );

    final args = Get.arguments;

    if (args != null && args is LoginArgs && args.fromSplashScreen) {
      Get.offAllNamed(Routes.cockpit);
    } else {
      Get.back();
      Get.back();
    }
    if(DynamicLinkModule.instance.hasPendingLink){
      DynamicLinkModule.instance.redirectPendingLink!();
    }
  }

  _onLoginError(String error) {
    _sessionManagerService.logout(logoutMessage: error);
  }

  onTapLogout() {
    _sessionManagerService.logout();
  }
}
