import 'package:flutter/material.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/environment/environment.dart';
import 'package:url_launcher/url_launcher.dart';

class OktaLogin {
  static void present(String email) {
    final config = Environment().config;
    launch(
      Uri.parse(
              '/okta.html?appUrl=${Urls.appUrl}&&user=${email}&&issuerUrl=${Urls.oktaIssuerUrl}&&idp=${config.bindIDIdp}&&clientId=${config.bindIDClient}')
          .toString(),
      webOnlyWindowName: '_self',
    );
  }
  
}
