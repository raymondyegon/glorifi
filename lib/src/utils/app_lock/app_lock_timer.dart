import 'dart:async';

abstract class AppLockTimer {
  Function()? onWatchDogLock;
  Function(int remainingSecond)? onTick;
  int activeTimeout;

  AppLockTimer({required this.activeTimeout, this.onWatchDogLock, this.onTick});

  Timer? timer;
  bool lockedByTimer = false;
  int remainingTime = 0;

  void startTimer() {
    lockedByTimer = false;
    cancelTimer();
    _initTimer();
  }

  _initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), checkOnTick);
  }

  void checkOnTick(Timer timer) {
    // Log.info(
    //     "AppLock timer running for $activeTimeout second, countdown $remainingTime");
    if (remainingTime <= 0 && !lockedByTimer) {
      _lockApp();
    } else {
      if (remainingTime > 0) {
        remainingTime--;
      }
    }
    onTick?.call(remainingTime);
  }

  _lockApp() {
    cancelTimer();
    lockedByTimer = true;
    onWatchDogLock?.call();
  }

  void initTimerForForeground();

  void initTimerForBackground();

  void cancelTimer() {
    if (timer?.isActive == true) {
      timer?.cancel();
    }
  }

  resetTimer() {
    remainingTime = activeTimeout;
  }
}
