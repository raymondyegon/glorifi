import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_watchdog_service.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_web_controller.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_web_dialog.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class AppLocker extends StatefulWidget {
  AppLocker({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<AppLocker> createState() => _AppLockerState();
}

class _AppLockerState extends State<AppLocker> with WidgetsBindingObserver {
  AppLockWatchdogService get appLockService =>
      Get.find<AppLockWatchdogService>();

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);

    if (kIsWeb) {
      listenToWebSessionTimeoutDialog();
      listenToPopTokenDialogForWeb();
    }
    super.initState();
  }

  StreamSubscription? webTokenExpirationSubscription;

  listenToWebSessionTimeoutDialog() {
    webTokenExpirationSubscription = appLockService
        .webTokenExpirationWaringStream
        .listen((bool tokenExpiresInOneMinute) {
      if (tokenExpiresInOneMinute) {
        _showAppLockDialog();
      }
    });
  }

  listenToPopTokenDialogForWeb() {
    final webController = Get.find<AppLockWebController>();
    webController.popWebDialog.listen((bool shouldLogout) {
      Log.info("trying to pop dialog");
      if (shouldLogout) {
        Navigator.of(context).pop(); //pop dialog
      }
    });
  }

  _showAppLockDialog() {
    final webController = Get.find<AppLockWebController>();
    webController.onStartDialogCountdown();
    showDialog(
        barrierDismissible: false,
        barrierColor: GlorifiColors.midnightBlue.withOpacity(0.8),
        context: context,
        builder: (BuildContext dialogContext) {
          return AppLockWebDialog();
        });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    webTokenExpirationSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        appLockService.initiateAutoLockForForeground(shouldCheckToken: true);
        Log.info("App resumed");
        break;
      case AppLifecycleState.paused:
        appLockService.initiateAutoLockForBackground();
        Log.info("App paused");
        break;
      default:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerCancel: (_) => _resetTimer(),
      onPointerDown: (_) => _resetTimer(),
      onPointerHover: (_) => _resetTimer(),
      onPointerMove: (_) => _resetTimer(),
      onPointerSignal: (_) => _resetTimer(),
      onPointerUp: (_) => _resetTimer(),
      child: widget.child,
    );
  }

  void _resetTimer() {
    appLockService.resetCountdown();
  }
}
