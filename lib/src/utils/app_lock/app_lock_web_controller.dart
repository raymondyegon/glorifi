import 'dart:async';

import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/login/controllers/token_refresh_mixin.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_watchdog_service.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class AppLockWebController extends GetxController {
  final _pageStateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageStateController.value;

  final _remainingSecondsController = 60.obs;

  int get remainingTime => _remainingSecondsController.value;

  final _popWebDialogController = StreamController<bool>.broadcast();

  get popWebDialog => _popWebDialogController.stream;

  Timer? timer;

  final _sessionManagerService = Get.find<SessionManagerService>();
  final _appLockService = Get.find<AppLockWatchdogService>();

  AppLockWebController(final int remainingTimeToLock){
    _remainingSecondsController(remainingTimeToLock);
  }

  onStartDialogCountdown() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), _onTimerTick);
  }

  _onTimerTick(Timer timer) {
    _remainingSecondsController(remainingTime - 1 >= 0 ? remainingTime - 1 : 0);
    if (remainingTime <= 0) {
      _popWebDialogController.sink.add(true);
      _appLockService.onWebTimeOut();
      timer.cancel();
    }
  }

  continueSession() async{
    timer?.cancel();
    _pageStateController(PageState.LOADING);

    final tokenRefresher = TokenRefresher(
      onTokenExchangeSuccess: _onTokenExchangeSuccess,
      onTokenExchangeError: _onTokenExchangeError,
    );
    await tokenRefresher.getAccessTokenFromRefreshToken();


    _pageStateController(PageState.DEFAULT);
  }

  _onTokenExchangeError(String error) async{
    showErrorToast("Can not continue this session, login again");
    logout();
  }

  _onTokenExchangeSuccess(dynamic response) async{
    Log.info("access token:  ${response['access_token']}");
    Log.info("refresh token:  ${response['refresh_token']}");

    _popWebDialogController.sink.add(true);
    await _sessionManagerService.onLoginSuccess(
      response['access_token'],
      response['refresh_token'],
    );
  }


  logout() {
    timer?.cancel();
    _popWebDialogController.sink.add(true);
    _appLockService.onWebTimeOut();
  }
}
