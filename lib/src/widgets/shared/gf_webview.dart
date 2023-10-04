import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/insurance/connection_failed/connection_failed.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../../routes/app_pages.dart';
import '../../utils/support/support_navigation_helper.dart';
import 'web_app_hyperlink_handler_stub.dart'
    if (dart.library.js) 'web_app_hyperlink_handler.dart';

import '../../core/data_helper.dart';
import '../../font_style_global.dart';

class GFWebview extends StatefulWidget {
  String? initialUrl;
  String? bindableUrl; // this url will used when redirecting from Unqork to Bindable
  String? vendor;
  final String pageTitle;
  final List<Widget>? actions;
  final Pattern? interceptUrl;
  final Function(String url)? interceptionHandler;

  GFWebview(
      {Key? key,
      required this.initialUrl,
      required this.pageTitle,
      this.bindableUrl,
      this.vendor,
      this.actions,
      this.interceptUrl,
      this.interceptionHandler})
      : super(key: key);

  @override
  State<GFWebview> createState() => _GFWebviewState();
}

class _GFWebviewState extends State<GFWebview> {
  bool fetchingSessionToken = true;
  String? sessionToken;
  Key webViewKey = GlobalKey();
  bool fetchingFailed = false;
  int? memberID;

  @override
  void initState() {
    super.initState();

    WebviewCookieManager().clearCookies();

    if (widget.vendor == "bindable" || widget.vendor == "vanepps") {
      //unauthenticated urls. No SSO hence no session token required.
      if (widget.initialUrl == null) {
        //null initial url will be only for bindable, where url needed to be generated using reroute api
        getBindableUrl();
      } else {
        getMemberId();
      }
    } else if (widget.vendor == 'unqork' ||
        widget.vendor == 'backbase' ||
        widget.vendor == 'blend') {
      getSessionToken();
    } else {
      fetchingSessionToken = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    String baseURL = assembleUrl();
    Log.debug('Webview URL: ${baseURL}');

    return Scaffold(
        appBar: GlorifiAppBar(
          title: widget.pageTitle,
          disableLeading: true,
          trailing: Trailing(
            onTap: Get.back,
            text: 'Close',
            textStyle: captionBold14Primary(
              color: GlorifiColors.darkOrange,
            ),
          ),
        ),
        body: fetchingFailed
            ? Center(
                child: ConnectionFailed(
                  title: widget.pageTitle,
                ),
              )
            : fetchingSessionToken
                ? Center(child: CircularProgressIndicator())
                : _buildWebViewX(baseURL));
  }

  Widget _buildWebViewX(String baseURL) {
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: Uri.parse(baseURL)),
      initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(useHybridComposition: true),
          crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true, useOnLoadResource: true)),
      androidOnPermissionRequest: (controller, origin, resources) async {
        return PermissionRequestResponse(
            resources: resources, action: PermissionRequestResponseAction.GRANT);
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var uri = navigationAction.request.url!;

        if (uri.toString().contains(Urls.appUrl)) {
          String? action = uri.queryParameters['action'];
          Log.debug('action $action');
          if (action == 'redirection') {
            String? destination = uri.queryParameters['destination'];
            Log.debug('destination $destination');
            if (destination == 'binadble' || destination == 'bindable') {
              //check login status and redirect to blend
              loadContinueCreateQuotePage();
            } else if (destination == 'support' || destination == 'faq') {
              //get category details and navigate to respective page
              String? category = uri.queryParameters['category'];
              SupportNavigationHelper.navigateToList(category);
            } else if (destination == 'home') {
              //navigate back from webview
              Get.back();
            } else {
              return NavigationActionPolicy.ALLOW;
            }
          } else if (action == 'exit') {
            Get.back();
          } else if (uri.path.contains('continueCreateQuote')) {
            loadContinueCreateQuotePage();
          } else {
            return NavigationActionPolicy.ALLOW;
          }
          return NavigationActionPolicy.CANCEL;
        } else {
          return NavigationActionPolicy.ALLOW;
        }
      },
      onLoadError: (controller, url, code, message) {
        Log.error('error $message');
      },
    );
  }

  Future<void> getSessionToken() async {
    final _dataHelper = DataHelperImpl.instance;
    final response = await _dataHelper.apiHelper.getSessionToken();
    response.fold(
      (l) {
        Log.error('Error fetching session token ${l}');
        setState(() {
          fetchingSessionToken = false;
          fetchingFailed = true;
        });
      },
      (r) {
        fetchingSessionToken = false;
        sessionToken = r['data'][0]['sessionToken'];
        Log.debug('Got session token: ${sessionToken}');
        if (kIsWeb) {
          String baseURL = assembleUrl();
          WebHyperLinkHandler().openUrl(baseURL);
          Get.back();
        } else {
          setState(() {});
        }
      },
    );
  }

  Future<void> getBindableUrl() async {
    final _dataHelper = DataHelperImpl.instance;
    final response = await _dataHelper.apiHelper.getBindableReroute();
    response.fold(
      (l) {
        setState(() {
          fetchingFailed = true;
        });
      },
      (r) {
        widget.initialUrl = r['data']['return_URL'];
        getMemberId();
      },
    );
  }

  Future<void> getMemberId() async {
    final _dataHelper = DataHelperImpl.instance;
    final response = await _dataHelper.apiHelper.getMemberDetails();
    response.fold(
      (l) {
        setState(() {
          fetchingFailed = true;
        });
      },
      (r) {
        fetchingSessionToken = false;
        memberID = r['data'][0]['member_id'];

        print('memberID Fetched ${memberID}');
        print('kSIWebi $kIsWeb');

        if (kIsWeb) {
          String baseURL = assembleUrl();
          WebHyperLinkHandler().openUrl(baseURL);
          Get.back();
        } else {
          setState(() {});
        }
      },
    );
  }

  String assembleUrl() {
    String baseURL = '';

    if (!fetchingSessionToken) {
      if (sessionToken != null) {
        if (widget.vendor == 'blend') {
          baseURL = '${Urls.blendSSOUrl}?sessionToken=$sessionToken';
        } else if (widget.vendor == 'unqork' || widget.vendor == 'backbase') {
          baseURL =
              '${Urls.oktaBaseUrl}/login/sessionCookieRedirect?token=${sessionToken}&redirectUrl=${widget.initialUrl}';
        }
      } else {
        if (widget.vendor == 'bindable' || widget.vendor == "vanepps") {
          baseURL = '${widget.initialUrl}$memberID';
        } else {
          baseURL = widget.initialUrl ?? '';
        }
      }
    }

    return baseURL;
  }

  void redirectToBindable() {
    setState(() {
      widget.vendor = "bindable";
      widget.initialUrl = widget.bindableUrl;
      fetchingSessionToken = true;
      sessionToken = null;
    });

    getMemberId();
  }

  void loadContinueCreateQuotePage() {
    Get.offAndToNamed(Routes.continueCreateQuote, parameters: {
      'title': widget.pageTitle,
      'vendor': "bindable",
      'initialUrl': widget.bindableUrl ?? ''
    });
  }
}
