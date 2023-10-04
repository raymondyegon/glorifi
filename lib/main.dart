import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/app_lock_notifier.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/services/authentication_service.dart';
import 'package:glorifi/src/services/okta_api_service.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/utils/adaptive/app_bar_web_controller.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_watchdog_service.dart';
import 'package:glorifi/storybook/main.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/controllers/global_appstate_notifier.dart';
import 'src/environment/environment.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

const storybook = bool.fromEnvironment('storybook', defaultValue: false);

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  WidgetsFlutterBinding.ensureInitialized();
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Initialize Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Elsewhere in your code
  //FirebaseCrashlytics.instance.crash();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  // Set the environment
  const String environment =
      String.fromEnvironment('ENVIRONMENT', defaultValue: Environment.dev);
  Environment().initConfig(environment);

  if (!storybook) {
    _startServices();
  }

  setPathUrlStrategy();
  runApp(
    storybook
        ? const MainStorybook()
        : ChangeNotifierProvider(
            lazy: false,
            create: (_) => GlobalAppStateNotifier(),
            child: ChangeNotifierProvider(
              create: (_) => AppLockNotifier(),
              child: MyApp(settingsController: settingsController),
            ),
          ),
  );
}

void _startServices() {
  if (kIsWeb) {
    final config = Environment().config;
    // for storing environment locally for web
    var myPref = window.localStorage['env'];
    window.localStorage['env'] = config.appUrl;
  }
  Get.lazyPut(() => AppLockWatchdogService(), fenix: true);
  Get.lazyPut(() => SessionManagerService(), fenix: true);
  Get.lazyPut(() => AuthenticationService(), fenix: true);
  Get.lazyPut(() => OKTA_APIService(), fenix: true);
  Get.lazyPut(() => ProfileController(), fenix: true);
  Get.lazyPut(() => GlobalAppBarWebController(), fenix: true);
}
