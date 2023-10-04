import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/biometric_auth_mixin.dart';
import 'package:glorifi/src/controllers/local_auth_controller.dart';
import 'package:glorifi/src/controllers/okta_mixin.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/login/models/login_args.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController
    with OktaMixin, BiometricAuthMixin {
  final SessionManagerService _sessionManagerService =
      Get.find<SessionManagerService>();

  final LocalAuthentication localAuthentication = LocalAuthentication();
  final _dataHelper = DataHelperImpl.instance;

  final pageState = PageState.DEFAULT.obs;

  final emailController = TextEditingController();

  bool get isEmailEmpty => emailController.text.isEmpty;

  bool get validEmail {
    return EmailValidator.validate(emailController.text);
  }

  //Password controller
  final pwdController = TextEditingController();

  bool get validPwd => pwdController.text.isNotEmpty;

  //Password field visibility controller
  final _passwordVisibilityController = true.obs;

  bool get passwordVisibility => _passwordVisibilityController.value;

  togglePasswordVisibility() =>
      _passwordVisibilityController(!passwordVisibility);

  //Login error with email and password
  final _loginErrorController = "".obs;

  Stream get loginErrorMsgStream => _loginErrorController.stream;

  String get loginErrorMsg => _loginErrorController.value;

  clearLoginError() => _loginErrorController("");

  @override
  void onInit() {
    checkSavedEmail();
    super.onInit();
  }

  void checkSavedEmail() async {
    var email = await _dataHelper.cacheHelper.getUserEmail();
    if (email.trim().isNotEmpty) {
      emailController.text = email;
    }
  }

  void checkForUserBiometricSettings() async {
    final refreshToken = await _dataHelper.cacheHelper.getRefreshToken();

    if (refreshToken.isEmpty) {
      //do nothing if refresh token is empty
      Log.info("Refresh token empty, skipping biometric authentication");
      return;
    }

    bool useLocalBiometric = await LocalAuth.isLocalBioEnabled();
    if (useLocalBiometric) {
      _loginUsingBiometric();
    } else {
      Log.info("useLocalBiometric = false, skipping biometric authentication");
    }
  }

  @override
  void onReady() {
    super.onReady();
    checkIfHasMessageToShow();
  }

  void checkIfHasMessageToShow() {
    final loginArgs = Get.arguments;
    if (loginArgs != null &&
        loginArgs is LoginArgs &&
        loginArgs.logoutMessage.trim().isNotEmpty) {
      showSnackBar(loginArgs.logoutMessage.trim());
    }
  }

  _loginUsingBiometric() async {
    loginUsingBiometric(
      onLoginSuccess: _onBiometricLoginSuccess,
      onLoginError: _onBiometricLoginError,
      onTokenExchangeStart: () => pageState(PageState.LOADING),
      onTokenExchangeDone: () => pageState(PageState.DEFAULT),
    );
  }

  _onBiometricLoginError(String error) {
    showSnackBar(error);
  }

  _onBiometricLoginSuccess(dynamic response) {
    Log.info("access token:  ${response['access_token']}");
    Log.info("refresh token:  ${response['refresh_token']}");
    _onLoginSuccess(response, byEmailPass: false);
  }

  // When using Username/Password
  _onLoginSuccess(dynamic res, {bool byEmailPass = true}) async {
    pageState(PageState.SUCCESS);

    await _sessionManagerService.onLoginSuccess(
        res['access_token'], res['refresh_token']);

    // Clear all Navigate to Feed
    Get.offNamedUntil(Routes.cockpit, ModalRoute.withName(Routes.devZone));
  }

  onTapLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    pageState(PageState.LOADING);
    emailController.text = emailController.text.trim();
    if (emailController.text.toLowerCase() == 'demo@applereviewer.com') {
      _demoUserLogin();
      return;
    }
    // Handle edge cases in Android preserving cookies in Chrome after deleting and installing the app
    if (Platform.isAndroid) {
      await _sessionManagerService.logout(navigateToLogin: false);
    }
    await loginUsingOkta(emailController.text, onLoginError: _onLoginError);
    pageState(PageState.DEFAULT);
  }

  _onLoginError(String error) {
    _loginErrorController(error);
  }

  //UI helpers
  bool forceHideEmailError = true;
  bool forceHidePasswordError = true;

  void disableForceHideError() {
    forceHideEmailError = false;
    forceHidePasswordError = false;
  }

  String? emailValidator(String? email) {
    if (loginErrorMsg.isNotEmpty) {
      return loginErrorMsg;
    } else if (forceHideEmailError) {
      return null;
    } else if (!validEmail) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }

  String? passwordValidator(String? email) {
    if (loginErrorMsg.isNotEmpty) {
      return loginErrorMsg;
    } else if (forceHidePasswordError) {
      return null;
    } else if (!validPwd) {
      return 'Please enter a valid password';
    } else {
      return null;
    }
  }

  _demoUserLogin() async {
    final response = await _dataHelper.apiHelper.demoUserLogin();
    response.fold((l) => null, _onLoginSuccess);
    pageState(PageState.DEFAULT);
  }
}
