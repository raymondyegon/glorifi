import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/login/models/login_args.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_watchdog_service.dart';
import 'package:glorifi/src/utils/okta_flutter_bridge.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SessionManagerService extends GetxService {
  AppLockWatchdogService get appLockService =>
      Get.find<AppLockWatchdogService>();
  final _dataHelper = DataHelperImpl.instance;

  Rx<bool> _isLoggedIn = false.obs;

  bool get loggedIn => _isLoggedIn.value;

  Rx<bool> get loggedInObserver => _isLoggedIn;

  Future<bool> isAccessTokenExpired() async {
    final apiToken = await _dataHelper.cacheHelper.getAccessToken();
    return _isTokenExpired(apiToken);
  }

  bool _isTokenExpired(String token) {
    try {
      Log.info(
          "Token expired: ${JwtDecoder.isExpired(token)}, expires in: ${JwtDecoder.getRemainingTime(token).inSeconds} seconds");
      return JwtDecoder.isExpired(token);
    } catch (e) {
      return true;
    }
  }

  Future<bool> onLoginSuccess(String access, String refresh) async {
    _isLoggedIn.value = true;
    await _saveTokens(access, refresh);
    if (!kIsWeb) {
      appLockService.lockedByLockedService = false;
      appLockService.initiateAutoLockForForeground();
    }
    return Future.value(_isLoggedIn.value);
  }

  _saveTokens(String access, String refresh) async {
    await _dataHelper.cacheHelper.saveAccessToken(access);
    await _dataHelper.cacheHelper.saveRefreshToken(refresh);
  }

  Future<void> logout(
      {String logoutMessage = "", bool navigateToLogin = true}) async {
    Log.info("Logging out");
    await _clearTokens();
    await _clearSessionData();
    await _logoutFromOkta();
    _onLogoutSuccess(logoutMessage, navigateToLogin);
  }

  _onLogoutSuccess(String logoutMessage, bool navigateToLogin) {
    _isLoggedIn.value = false;
    appLockService.stopTimer();
    //clear all screen and move to login screen if necessary
    if (navigateToLogin) {
      Get.offAllNamed(Routes.login,
          arguments: LoginArgs(logoutMessage: logoutMessage));
    }
  }

  _clearTokens() async {
    await _dataHelper.cacheHelper.clearTokens();
  }

  _clearSessionData() async {
    //clear value screen skipping
    await _dataHelper.cacheHelper.updateSkipValueScreen(true);
  }

  _logoutFromOkta() async {
    if (kIsWeb) {
      await _clearTokens();
      await _clearSessionData();
      return;
    }
    //Todo implement
    //make a logout to okta
    if (Platform.isAndroid) {
      // Ensure that okta has been initialized before attempting to use it. This is to ensure AppLock screen successfully logs the user out
      await OktaFlutterBridge.initOkta();
      return await OktaFlutterBridge.oktaLogOut();
    }
    Log.warning("Not implemented: Clearing okta");
  }
}
