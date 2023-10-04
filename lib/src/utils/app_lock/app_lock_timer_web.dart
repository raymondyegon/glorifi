import 'dart:async';

import 'package:get/get.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_timer.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_web_controller.dart';

class AppLockTimerWeb extends AppLockTimer {
  ///App inactivity timeout
  static const WEB_TIMEOUT_SEC_FOR_APP_LOCK = 15 * 60;

  //show web dialog when this amount of time remaining
  int showWebDialogTimeout = 60;

  Function()? onRemainingOneMinute;

  bool notifiedOneMinuteLeft = false;

  AppLockTimerWeb({final Function()? onWatchDogLock, this.onRemainingOneMinute})
      : super(
            activeTimeout: WEB_TIMEOUT_SEC_FOR_APP_LOCK.toInt(),
            onWatchDogLock: onWatchDogLock) {
    Get.lazyPut(() => AppLockWebController(showWebDialogTimeout));
  }

  @override
  checkOnTick(Timer timer) {
    if (remainingTime <= showWebDialogTimeout &&
        !lockedByTimer &&
        !notifiedOneMinuteLeft) {
      notifiedOneMinuteLeft = true;
      onRemainingOneMinute?.call();
    }

    if (remainingTime > showWebDialogTimeout) {
      notifiedOneMinuteLeft = false;
    }

    super.checkOnTick(timer);
  }

  @override
  void initTimerForBackground() {
    resetTimer();
    startTimer();
  }

  @override
  void initTimerForForeground() {
    resetTimer();
    startTimer();
  }
}
