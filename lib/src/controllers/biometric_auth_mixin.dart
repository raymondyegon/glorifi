import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/login/controllers/token_refresh_mixin.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:local_auth/local_auth.dart';

mixin BiometricAuthMixin {
  final SessionManagerService _sessionManagerService =
      Get.find<SessionManagerService>();

  final LocalAuthentication localAuthentication = LocalAuthentication();

  final _dataHelper = DataHelperImpl.instance;

  Function(dynamic respone)? _onLoginSuccess;
  Function(String error)? _onLoginError;
  Function()? _onTokenExchangeStart;
  Function()? _onTokenExchangeDone;

  loginUsingBiometric({
    Function(dynamic respone)? onLoginSuccess,
    Function(String error)? onLoginError,
    Function()? onTokenExchangeStart,
    Function()? onTokenExchangeDone,
  }) async {
    _onLoginSuccess = onLoginSuccess;
    _onLoginError = onLoginError;
    _onTokenExchangeStart = onTokenExchangeStart;
    _onTokenExchangeDone = onTokenExchangeDone;

    final isAuthenticated = await authenticateWithBiometrics();
    if (isAuthenticated) {
      await _exchangeRefreshToken();
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (canCheckBiometrics) {
      cancelBiometricIfActive();
    }

    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: "Verify it's you",
          biometricOnly: false, //use pattern/pin as a fallback
          sensitiveTransaction: false,
          useErrorDialogs: true,
        );
      } on PlatformException catch (platformException) {
        isAuthenticated = false;
      }
    }

    return isAuthenticated;
  }

  void cancelBiometricIfActive() async {
    await localAuthentication.stopAuthentication();
  }

  _exchangeRefreshToken() async {
    _onTokenExchangeStart?.call();

    //Validate token only if access token expired
    if (await _sessionManagerService.isAccessTokenExpired()) {
      final tokenRefresher = TokenRefresher(
        onTokenExchangeSuccess: _onTokenExchangeSuccess,
        onTokenExchangeError: _onTokenExchangeError,
      );
      await tokenRefresher.getAccessTokenFromRefreshToken();
    } else {
      final currentAccessToken = await _dataHelper.cacheHelper.getAccessToken();
      final currentRefreshToken =
          await _dataHelper.cacheHelper.getRefreshToken();
      var response = {
        'access_token': currentAccessToken,
        'refresh_token': currentRefreshToken,
      };
      _onTokenExchangeSuccess(response);
    }

    _onTokenExchangeDone?.call();
  }

  _onTokenExchangeError(String error) {
    _dataHelper.cacheHelper.clearTokens();
    _onLoginError?.call(error);
    _sessionManagerService.logout();
  }

  _onTokenExchangeSuccess(dynamic response) {
    Log.info("access token:  ${response['access_token']}");
    Log.info("refresh token:  ${response['refresh_token']}");
    _onLoginSuccess?.call(response);
  }
}
