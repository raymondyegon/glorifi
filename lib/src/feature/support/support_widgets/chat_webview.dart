import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/containers/loading_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatWebView extends StatelessWidget {
  // late SupportNavigationController supportNavigationController;
  late FAQCategoriesController faqCategoriesController;

  ChatWebView({Key? key}) : super(key: key) {
    // supportNavigationController = Get.find<SupportNavigationController>();
    faqCategoriesController = Get.find<FAQCategoriesController>();
    print('CHatWebView constructor');
  }

  final webStateController = PageState.DEFAULT.obs;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? params = Get.arguments;
    final validKeys = [
      'RoutingKey',
      'MemberID',
      'MemberEmail',
      'MemberName',
      'MemberPhone',
      'FinalIntent'
    ];

    if (params == null) {
      // params = supportNavigationController.webViewArguments;
      params = faqCategoriesController.webViewArguments;
    }

    params.removeWhere((key, value) => !validKeys.contains(key));

    var routingKey = params['RoutingKey'] ?? 'General';
    routingKey =
        routingKey[0].toUpperCase() + routingKey.substring(1).toLowerCase();
    params['RoutingKey'] = routingKey;
    params['MemberID'] = params['MemberID'] ?? '';
    Log.debug('params ${params}');

    final messenger = Uri.https('support-chat.pat-glorifi.com', '', params);
    Log.debug('Messenger URI: $messenger');
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      resizeToAvoidBottomInset: faqCategoriesController.isBottomSheet
          ? false
          : isIOS
              ? false
              : true,
      appBar: GlorifiAppBar(
        title: TextConstants.chatWithAnAgent,
        disableLeading: true,
        trailing: Trailing(
          onTap: () {
            if (faqCategoriesController.isBottomSheet) {
              faqCategoriesController.navigationStack.removeAt(0);
              faqCategoriesController.update();
            } else {
              Get.back();
            }
          },
          text: TextConstants.cancelText,
        ),
      ),
      body: LoadingContainer(
        loadingControllers: [webStateController],
        child: WebView(
          initialUrl: messenger.toString(),
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: false,
          debuggingEnabled: true,
          onPageStarted: (value) => webStateController(PageState.LOADING),
          onPageFinished: (value) => webStateController(PageState.DEFAULT),
        ),
      ),
    );
  }
}
