// Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../services/session_manager_service.dart';
import 'app_pages.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  final _sessionManagerService = Get.find<SessionManagerService>();

  RouteSettings? redirect(String? route) {
    String returnUrl = Uri.encodeFull(route ?? '');
    return !_sessionManagerService.loggedIn
        ? RouteSettings(name: Routes.LOGIN_THEN(returnUrl))
        : null;
  }

// @override
// Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
//   // you can do whatever you want here
//   // but it's preferable to make this method fast
//   // await Future.delayed(Duration(milliseconds: 500));
//   bool isExpired = await _sessionManagerService.isAccessTokenExpired();
//   if (isExpired) {
//     final newRoute = Routes.LOGIN_THEN(route.location!);
//     return GetNavConfig.fromRoute(newRoute);
//   }
//   return await super.redirectDelegate(route);
// }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  final _sessionManagerService = Get.find<SessionManagerService>();

  RouteSettings? redirect(String? route) {
    return _sessionManagerService.loggedIn
        ? RouteSettings(name: Routes.cockpit)
        : RouteSettings(name: route);
  }
}
