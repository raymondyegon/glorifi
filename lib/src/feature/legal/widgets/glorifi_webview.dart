import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/containers/loading_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GlorifiWebView extends StatelessWidget {
  final String title;
  final String url;

  GlorifiWebView({
    required this.title,
    required this.url,
    Key? key,
  }) : super(key: key);

  final webStateController = PageState.DEFAULT.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(title: title),
      body: SafeArea(
        child: LoadingContainer(
          loadingControllers: [webStateController],
          child: WebView(
            initialUrl: url,
            onPageStarted: (value) => webStateController(PageState.LOADING),
            onPageFinished: (value) => webStateController(PageState.DEFAULT),
          ),
        ),
      ),
    );
  }
}
