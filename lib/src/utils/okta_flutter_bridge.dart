import 'package:flutter/services.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/environment/environment.dart';

class OktaFlutterBridge {
  static const oktaInitDone = "okta_init_dont";

  static const MethodChannel _channel = MethodChannel('okta_flutter_bridge');

  static Future<String> initOkta() async {
    final config = Environment().config;
    Map<String, dynamic> data = {
      'scopes': 'openid profile offline_access',
      'clientId': config.bindIDClient,
      'redirectUri': Urls.oktaRedirectUrl,
      'issuer': Urls.oktaIssuerUrl,
      'logoutRedirectUri': Urls.oktaLogoutRedirectUrl,
      'idp': config.bindIDIdp,
      'prompt': 'login'
    };

    final String status = await _channel.invokeMethod('initOkta', data);
    return status;
  }

  static Future<String> oktaLogOut() async {
    final config = Environment().config;
    Map<String, dynamic> data = {
      'scopes': 'openid profile offline_access',
      'clientId': config.bindIDClient,
      'redirectUri': Urls.oktaRedirectUrl,
      'issuer': Urls.oktaIssuerUrl,
      'logoutRedirectUri': Urls.oktaLogoutRedirectUrl,
      'idp': config.bindIDIdp,
      'prompt': 'login'
    };
    final String status = await _channel.invokeMethod('oktaLogOut', data);
    return status;
  }

  static Future<Map<dynamic, dynamic>> authenticate(
      String loginHint, bool isNewAccount) async {
    Map<String, dynamic> data = {
      'loginHint': loginHint,
      'isNewAccount': isNewAccount ? 'true' : 'false',
    };
    final Map<dynamic, dynamic> token = await _channel.invokeMethod('authenticate', data);
    return token;
  }

  static void openSettingsPage() {
    _channel.invokeMethod('openSettingsPage');
  }
}
