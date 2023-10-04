import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/close_app_bar.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/containers/loading_container.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:universal_html/html.dart' as html;
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
  Factory(() => EagerGestureRecognizer())
};

class ExternalArticleModal extends StatefulWidget {
  final String url;
  final bool isWeb;

  ExternalArticleModal({Key? key, required this.url, required this.isWeb})
      : super(key: key);

  @override
  State<ExternalArticleModal> createState() => _ExternalArticleModalState();
}

class _ExternalArticleModalState extends State<ExternalArticleModal> {
  final webStateController = PageState.DEFAULT.obs;

  @override
  void initState() {
    super.initState();
    if (widget.isWeb) {
      openWebPage(widget.url);
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlorifiColors.productsBgWhite,
      padding: EdgeInsets.only(top: 23.h),
      child: Scaffold(
          appBar: GlorifiAppBar(
            title: "GloriFi",
            disableLeading: true,
            trailing: Trailing(
              onTap: () {
                Get.back();
              },
              text: "Close",
              textStyle: captionSemiBold14Primary(
                color: GlorifiColors.darkOrange,
              ),
            ),
          ),
          body: LoadingContainer(
              loadingControllers: [webStateController],
              child: WebView(
                initialUrl: widget.url,
                gestureRecognizers: gestureRecognizers,
                onPageStarted: (value) => webStateController(PageState.LOADING),
                onPageFinished: (value) =>
                    webStateController(PageState.DEFAULT),
              ))),
    );
  }

  openWebPage(String url) {
    html.window.open(url, "_blank");
  }
}
