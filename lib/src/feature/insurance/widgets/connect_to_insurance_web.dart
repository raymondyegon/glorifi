import 'package:flutter/material.dart';
import 'package:glorifi/src/widgets/shared/gf_webview.dart';

class ConnectToInsuranceWeb extends StatelessWidget {
  const ConnectToInsuranceWeb(
      {Key? key, required this.url, this.vendor, required this.title, this.bindableUrl})
      : super(key: key);
  final String? url;
  final String? vendor;
  final String title;
  final String? bindableUrl;

  @override
  Widget build(BuildContext context) {
    return GFWebview(
      initialUrl: url,
      pageTitle: title,
      vendor: vendor,
      bindableUrl: bindableUrl,
    );
  }
}
