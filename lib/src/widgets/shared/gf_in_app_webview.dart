import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter/material.dart';

class GFInAppWebview extends StatefulWidget {
  final browser = ChromeSafariBrowser();
  GFInAppWebview({Key? key}) : super(key: key);

  @override
  State<GFInAppWebview> createState() => _GFInAppWebviewState();
}

class _GFInAppWebviewState extends State<GFInAppWebview> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            await widget.browser.open(
                url: Uri.parse("https://oktabindiddemo.azurewebsites.net"),
                options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                        addDefaultShareMenuItem: false),
                    ios: IOSSafariOptions(barCollapsingEnabled: true)));
          },
          child: const Text("Open InAppBrowser")),
    );
  }
}
