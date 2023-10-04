import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/api/api_endpoints.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:glorifi/src/environment/environment.dart';
import 'package:glorifi/src/widgets/shared/gf_webview.dart';

class OpenAccount extends StatelessWidget {
  late WebViewController webViewController;
  Map<String, dynamic> arguments = Get.arguments; //none,checking,cd,new,plaid
  String? vendor;

  @override
  Widget build(BuildContext context) {
    // var accountType =
    //     arguments["accountType"] as AccountType; //checking,saving, cd
    var title = 'Banking';

    var url = Environment().config.backbaseUrl + onBoarding;
    vendor = 'backbase';

    if (arguments["plaidAccount"]) {
      url = ApiEndPoints.plaidWebhookUrl;
      title = "External";
      vendor = 'plaid';
    } else if (arguments["connected"]) {
      url = Environment().config.backbaseUrl + retailApp;
      title = "connected";
      vendor = 'backbase';
    }

    return Scaffold(
        body: GFWebview(
      pageTitle: title,
      initialUrl: url,
      vendor: vendor,
    ));
  }
}
