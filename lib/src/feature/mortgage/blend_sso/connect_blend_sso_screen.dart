import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/widgets/shared/gf_webview.dart';

class ConnectBlendSsoScreen extends StatelessWidget {
  ConnectBlendSsoScreen({Key? key}) : super(key: key) {
    title = Get.parameters['title'] ?? 'Blend';
  }

  String title = '';

  @override
  Widget build(BuildContext context) {
    return GFWebview(
      initialUrl: Urls.blendSSOUrl,
      pageTitle: title,
      vendor: "blend",
    );
  }
}
