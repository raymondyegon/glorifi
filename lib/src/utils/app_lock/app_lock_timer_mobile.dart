import 'package:glorifi/src/utils/app_lock/app_lock_timer.dart';

class AppLockTimerMobile extends AppLockTimer {
  ///App inactivity timeout
  static const FOREGROUND_TIMEOUT_SEC_FOR_APP_LOCK = 5 * 60;

  ///App lock timeout while app in background
  static const BACKGROUND_TIMEOUT_SEC_FOR_APP_LOCK = 5 * 60;

  AppLockTimerMobile({final Function()? onWatchDogLock})
      : super(
            onWatchDogLock: onWatchDogLock,
            activeTimeout: FOREGROUND_TIMEOUT_SEC_FOR_APP_LOCK);

  @override
  initTimerForForeground() {
    activeTimeout = FOREGROUND_TIMEOUT_SEC_FOR_APP_LOCK;
    resetTimer();
    startTimer();
  }

  @override
  initTimerForBackground() {
    activeTimeout = BACKGROUND_TIMEOUT_SEC_FOR_APP_LOCK;
    resetTimer();
    startTimer();
  }
}
