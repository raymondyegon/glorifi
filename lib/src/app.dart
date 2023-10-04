import 'package:alice/alice.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/analytics.dart';
import 'package:glorifi/src/core/dynamic_link_module.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/settings/settings_controller.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_screen_type.dart';
import 'package:glorifi/src/utils/app_lock/app_locker.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/theme.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Alice alice = Alice(
  showNotification: true,
  navigatorKey: navigatorKey,
  showInspectorOnShake: true,
  darkTheme: false,
  maxCallsCount: 1000,
);

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    //lock app orientation to portrait
    _lockOrientation();

    //set status bar icon colors
    _setStatusBarColors();

    _initDynamicLinks();

    super.initState();
    Analytics.init();
  }

  Future<void> _initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      DynamicLinkModule.instance.processDynamicLink(dynamicLinkData);
    }).onError(Log.error);
  }

  void _setStatusBarColors() {
    SystemChrome.setSystemUIOverlayStyle(
      _statusBarColorSettings(),
    );
  }

  SystemUiOverlayStyle _statusBarColorSettings() {
    return SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, //Android
      statusBarBrightness: Brightness.dark, //iOS
    );
  }

  void _lockOrientation() {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    // Get.put(MemberController());
    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return AdaptiveBuilder(
          builder: (context, sizingInfo) {
            return ResponsiveUtilInit(
              designSize: sizingInfo.deviceType == AdaptiveScreenType.desktop
                  ? Size(1440, 1024)
                  : sizingInfo.deviceType == AdaptiveScreenType.nativeMobile
                      ? Size(390, 844)
                      : sizingInfo.deviceType == AdaptiveScreenType.webMobile
                          ? Size(428, 844)
                          : Size(752, 1280),
              builder: () => AppLocker(
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: _statusBarColorSettings(),
                  child: GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    navigatorKey: alice.getNavigatorKey(),

                    // Provide the generated AppLocalizations to the MaterialApp. This
                    // allows descendant Widgets to display the correct translations
                    // depending on the user's locale.
                    localizationsDelegates: const [
                      //   AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en', ''), // English, no country code
                    ],
                    darkTheme: CustomTheme.basicTheme,
                    themeMode: widget.settingsController.themeMode,
                    getPages: AppPages.pages,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
