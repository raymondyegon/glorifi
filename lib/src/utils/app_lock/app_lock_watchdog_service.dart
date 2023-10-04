import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/local_auth_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/onboard/login/models/login_args.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_timer.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_timer_mobile.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_timer_web.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// ignore_for_file: always_put_control_body_on_new_line
class AppLockWatchdogService extends GetxService {
  final _sessionManager = Get.find<SessionManagerService>();

  bool get isUserLoggedIn => _sessionManager.loggedIn;

  final _appLockController = StreamController<bool>.broadcast();

  Stream<bool> get appLockedStream => _appLockController.stream;

  set setAppLocked(bool isAppLocked) =>
      _appLockController.sink.add(isAppLocked);

  bool _isLockedByLockService = false;

  set lockedByLockedService(bool isLocked) => _isLockedByLockService = isLocked;

  final _webTokenExpirationWaringController =
      StreamController<bool>.broadcast();

  Stream<bool> get webTokenExpirationWaringStream =>
      _webTokenExpirationWaringController.stream;

  late final AppLockTimer _appLockTimer;

  AppLockWatchdogService() {
    _appLockTimer = kIsWeb
        ? AppLockTimerWeb(onRemainingOneMinute: onOneMinuteTimeoutForWeb)
        : AppLockTimerMobile(onWatchDogLock: _onLock);
  }

  onWebTimeOut() {
    _onLock();
  }

  void _onLock() {
    if (!isAppLockable) return;

    _isLockedByLockService = true;
    _appLockController.sink.add(true);

    // NOTE : We are disable auto-lock feature for QA. QA is getting problems with automated testing.
    //  The app has an auto-lock feature that kicks in after a certain number of minutes and when it does,
    //  it breaks the script automation execution. This app feature is a blocker for test automation.

    //FIXME  Please enable it before you launch APK. Thanks
   // _lockApp();
  }

  initiateAutoLockForForeground({bool shouldCheckToken = false}) async {
    if (!isAppLockable) {
      stopTimer();
      return;
    }

    if (shouldCheckToken) {
      bool isLocking = await lockAppForExpiredToken();
      if (isLocking) return;
    }

    _appLockTimer.initTimerForForeground();
  }

  initiateAutoLockForBackground() {
    if (!isAppLockable) {
      stopTimer();
      return;
    }

    _appLockTimer.initTimerForBackground();
  }

  resetCountdown() {
    _appLockTimer.resetTimer();
  }

  stopTimer() {
    _appLockTimer.cancelTimer();
  }

  Future<bool> lockAppForExpiredToken() async {
    bool tokenExpired = await _isAccessTokenExpired();
    if (tokenExpired) {
      _onLock();
      return true;
    } else {
      return false;
    }
  }

  _isAccessTokenExpired() async {
    final apiToken = await DataHelperImpl.instance.cacheHelper.getAccessToken();
    return JwtDecoder.isExpired(apiToken);
  }

  bool get isAppLockable => !_isLockedByLockService && isUserLoggedIn;

  void onApiCallDone() {
    // Log.info("Resetting counter on api calling done");
    resetCountdown();
  }

  onOneMinuteTimeoutForWeb() {
    _webTokenExpirationWaringController.sink.add(true);
  }

  void _lockApp() async {
    if (kIsWeb) {
      _sessionManager.logout();
      return;
    }

    final localBioEnabled = await LocalAuth.isLocalBioEnabled();

    if (localBioEnabled == true) {
      _navigateToLockScreen();
    } else {
      _sessionManager.logout();
    }
  }

  void _navigateToLockScreen() {
    Get.toNamed(Routes.appLockScreen, arguments: LoginArgs(fromAppLock: true));
  }
}
