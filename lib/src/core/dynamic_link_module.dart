import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/services/session_manager_service.dart';

class DynamicLinkModule {
  DynamicLinkModule._();

  static DynamicLinkModule _instance = DynamicLinkModule._();

  static DynamicLinkModule get instance => _instance;

  bool hasPendingLink = false;
  Function()? redirectPendingLink;

  processDynamicLink(PendingDynamicLinkData dynamicLink) {
    Map<String, dynamic> params = getParameters(dynamicLink.link.query);

    /// if require_login=true -> check/request login then do stuff
    if (params.containsKey('require_login')) {
      if (params['require_login'] == 'true') {
        final SessionManagerService _sessionManagerService = Get.find<SessionManagerService>();
        if (_sessionManagerService.loggedIn) {
          Get.toNamed(dynamicLink.link.path);
        } else {
          redirectPendingLink = () {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              Get.toNamed(dynamicLink.link.path);
            });
            redirectPendingLink = null;
            hasPendingLink = false;
          };
          hasPendingLink = true;
        }
        return;
      }
    }

    Get.toNamed(dynamicLink.link.path);
  }

  /// Get parameters from url link
  static Map<String, dynamic> getParameters(String query) {
    final Map<String, dynamic> parameters = {};
    final List<String> pairs = query.split('&');
    for (String pair in pairs) {
      final List<String> parsed = pair.split('=');

      parameters[parsed.first] = parsed.last;
    }

    return parameters;
  }
}
