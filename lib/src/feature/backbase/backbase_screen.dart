import 'package:flutter/material.dart';
import 'package:glorifi/src/environment/environment.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:glorifi/src/utils/support/support_navigation_helper.dart';
import 'package:glorifi/src/widgets/shared/gf_webview.dart';

class BackBaseScreen extends StatelessWidget {
  const BackBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String interceptUrl =
        'http://glorify.com/redirection?destination=faq_banking';
    return GFWebview(
      initialUrl: Environment().config.backbaseUrl + retailApp,
      vendor: "backbase",
      pageTitle: 'Backbase',
      interceptUrl: interceptUrl,
      interceptionHandler: (interceptUrl) async {
        interceptUrl =
            'http://glorify.com?action=redirection&destination=faq&category=banking'; //todo remove this
        var uri = Uri.dataFromString(interceptUrl);
        if (uri.queryParameters[actionKey] == redirection) {
          // String? destination = uri.queryParameters['destination'];

          String? destination = uri.queryParameters[destinationKey];

          if (destination == destinationFAQ) {
            String? category = uri.queryParameters[categoryKey];
            SupportNavigationHelper.navigateToList(category);
          }
        }
      },
    );
  }
}
