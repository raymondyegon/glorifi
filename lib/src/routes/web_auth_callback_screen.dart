import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

import '../services/session_manager_service.dart';
import 'app_pages.dart';

class WebAuthCallBackScreen extends StatefulWidget {
  const WebAuthCallBackScreen({Key? key}) : super(key: key);

  @override
  State<WebAuthCallBackScreen> createState() => _WebAuthCallBackScreenState();
}

class _WebAuthCallBackScreenState extends State<WebAuthCallBackScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() async {
    final SessionManagerService _sessionManagerService =
        Get.find<SessionManagerService>();
    navigateToNext(_sessionManagerService);
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffoldWeb().getScaffold(
      body: const SizedBox(),
      context: context,
    );
  }

  void navigateToNext(SessionManagerService sessionManagerService) async {
    await sessionManagerService
        .onLoginSuccess(
          Get.parameters['access_token'].toString(),
          Get.parameters['id_token'].toString(),
        )
        .then((value) => Get.offAllNamed(Routes.cockpit));
  }
}
