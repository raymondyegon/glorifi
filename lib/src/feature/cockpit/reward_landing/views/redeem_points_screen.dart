import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/containers/loading_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RedeemPointsScreen extends StatelessWidget {
  final String redeemUrl;
  RedeemPointsScreen({Key? key, required this.redeemUrl}) : super(key: key);

  final webStateController = PageState.DEFAULT.obs;
  LoyaltyController get loyaltyController => Get.find<LoyaltyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: "Redeem Points",
        disableLeading: true,
        trailing: Trailing(
          text: "Close",
          onTap: Get.back,
        ),
      ),
      body: SafeArea(
        child: LoadingContainer(
            loadingControllers: [webStateController],
            child: WebView(
              initialUrl: redeemUrl,
              // Breakaway loyalty site will not load without JS
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (value) => webStateController(PageState.LOADING),
              onPageFinished: (value) => webStateController(PageState.DEFAULT),
              onWebResourceError: (error) =>
                  webStateController(PageState.DEFAULT),
            )),
      ),
    );
  }
}
