import 'dart:io';
import 'package:flutter_share/flutter_share.dart';
import 'package:glorifi/src/services/rewards_service.dart';

class ShareAppUtil {
  static Future<void> showShareApp(
      String? title, String? text, String? chooserTitle) async {
    bool? _sharedresult = await FlutterShare.share(
      title: 'Have you heard?',
      text: "Checkout GloriFi: Financial Lifestyle",
      linkUrl: _getAppStoreLink(),
    );

    if (_sharedresult! == true) {
      RewardsService.sharedApp();
    }
  }

  static String _getAppStoreLink() {
    String returnUrl = "www.glorifi.com/share";
    if (Platform.isIOS) {
      returnUrl =
          "https://apps.apple.com/us/app/glorifi-financial-lifestyle/id1620570513";
    } else if (Platform.isAndroid) {
      // FIXME: Proper Play store url
      returnUrl =
          "https://play.google.com/apps/internaltest/4700576433614748767";
    }
    return returnUrl;
  }
}
