import 'dart:async';

import 'package:flutter/material.dart';

class AppLockNotifier extends ChangeNotifier {
  late final StreamSubscription<bool> _controller;
  late final Stream<bool> _stream;
  late final Stream<int> _timerStream;
  bool _isAppLocked = false;
  bool _allowAutoLock = false;
  int _durationInSeconds = 30;

  bool get isAppLocked => _isAppLocked;

  StreamSubscription<bool> get isAppLockedStream => _controller;

  Stream<int> get timerStream => _timerStream;

  bool get allowAutoLock => _allowAutoLock;

  set setAllowAutoLock(bool allowAutoLock) {
    _allowAutoLock = allowAutoLock;
    resetTimer();
  }

  set setAppLocked(bool isAppLocked) {
    _isAppLocked = isAppLocked;
    resetTimer();
  }

  AppLockNotifier() {
    _stream = Stream<bool>.periodic(Duration(seconds: 1), (comp) => _lockApp());
    _timerStream =
        Stream.periodic(Duration(seconds: 1), (comp) => _durationInSeconds);
    _controller = _stream.listen((event) {});
  }

  bool _lockApp() {
    if (_durationInSeconds <= 0 && !_isAppLocked && _allowAutoLock) {
      _isAppLocked = true;
      return true;
    } else {
      _durationInSeconds--;
      return false;
    }
  }

  void resetTimer() {
    _durationInSeconds = 30;
    notifyListeners();
  }

  void dispose() {
    _controller.cancel();
    super.dispose();
  }
}
