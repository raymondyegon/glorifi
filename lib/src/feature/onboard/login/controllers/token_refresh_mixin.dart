import 'dart:convert';

import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class TokenRefresher {
  final _dataHelper = DataHelperImpl.instance;
  final Function(dynamic response)? onTokenExchangeSuccess;
  final Function(String error)? onTokenExchangeError;

  TokenRefresher({
    this.onTokenExchangeSuccess,
    this.onTokenExchangeError,
  });

  Future getAccessTokenFromRefreshToken() async {
    await _exchangeRefreshTokenForOkta();
  }

  _exchangeRefreshTokenForOkta() async {
    final refreshToken = await _dataHelper.cacheHelper.getRefreshToken();
    final response =
        await _dataHelper.apiHelper.getAccessTokenForOkta(refreshToken);
    await response.fold(_onOktaTokenExchangeFailed, _onTokenExchangeSuccess);
  }

  _onOktaTokenExchangeFailed(CustomException exception) {
    String error = "Unable to login. Try other methods!";
    try {
      final errorResponse = jsonDecode(exception.errorMessage);
      error = errorResponse['error_description'] ?? error;
    } catch (e) {
      Log.error(e.toString());
    }

    if(onTokenExchangeError != null){
      onTokenExchangeError?.call(error);
    } else {
      showSnackBar(error);
    }
  }

  _onTokenExchangeSuccess(dynamic response) {
    Log.info("access token:  ${response['access_token']}");
    Log.info("refresh token:  ${response['refresh_token']}");
    onTokenExchangeSuccess?.call(response);
  }
}
