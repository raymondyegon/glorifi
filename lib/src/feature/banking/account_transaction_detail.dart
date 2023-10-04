import 'package:flutter/material.dart';
import 'package:glorifi/src/widgets/shared/gf_webview.dart';

class AccountTransactionDetail extends StatelessWidget {
  const AccountTransactionDetail(
      {Key? key, required this.url, this.vendor, required this.title})
      : super(key: key);
  final String? url;
  final String? vendor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GFWebview(
      initialUrl: url,
      pageTitle: title,
      vendor: vendor,
    );
  }
}
