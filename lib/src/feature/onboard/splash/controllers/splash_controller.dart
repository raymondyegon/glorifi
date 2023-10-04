import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/local_auth_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/environment/environment.dart';
import 'package:glorifi/src/feature/onboard/login/models/login_args.dart';
import 'package:glorifi/src/feature/update_handler/controllers/update_handler_controllers.dart';
import 'package:glorifi/src/model/update_handler_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:safe_device/safe_device.dart';

class SplashController extends BaseController {
  static const DEFAULT_SPLASH_ASSET = "assets/images/splash/splash_image_1.png";
  final _splashBgAssetController = DEFAULT_SPLASH_ASSET.obs;
  var updateTerms = UpdateTerms.updated;

  String get splashImageAssetNameWithPath => _splashBgAssetController.value;

  @override
  void onInit() async {
    _getSplashImage();
    super.onInit();
    await Future.delayed(Duration(seconds: 2));
    navigateToNextScreen();
  }

  _getSplashImage() async {
    DataHelper dataHelper = DataHelperImpl.instance;
    int splashBgNumber = await dataHelper.cacheHelper.getSplashBgNumber();
    _splashBgAssetController(
        "assets/images/splash/splash_image_$splashBgNumber.png");
  }

  void navigateToNextScreen() async {
    final updateTerms = await isUpdateAvailable();
    if (updateTerms != UpdateTerms.updated) {
      final arguments = await Get.toNamed(Routes.updateHandlerScreen,
          arguments: LoginArgs(updateTerms: updateTerms)) as LoginArgs;
      if (arguments.updateTerms == UpdateTerms.updated) {
        jumpToDeciededScreen();
      } else {
        return;
      }
    } else {
      jumpToDeciededScreen();
    }
  }

  Future<void> jumpToDeciededScreen() async {
    final nextScreenRouteName = await decideNextScreen();
    Get.offNamed(nextScreenRouteName,
        arguments: LoginArgs(fromSplashScreen: true));
  }

  Future<String> decideNextScreen() async {
    final DataHelper dataHelper = DataHelperImpl.instance;
    final skipValueScreen = await dataHelper.cacheHelper.skipValueScreen();
    String nextScreenRoute = "";

    if (kIsWeb) {
      nextScreenRoute = Routes.login;
    } else {
      bool isJailBroken = await SafeDevice.isJailBroken;

      String environment = Environment().config.name;

      if (isJailBroken && environment == Environment.prod) {
        return Routes.UNSAFE_DEVICE_DETECTED;
      }

      if (skipValueScreen) {
        final refreshToken =
            await DataHelperImpl.instance.cacheHelper.getRefreshToken();
        bool? localBioEnabled = await LocalAuth.isLocalBioEnabled();
        if (refreshToken.trim().isNotEmpty && localBioEnabled == true) {
          nextScreenRoute = Routes.appLockScreen;
        } else {
          // Log out when we show the Login screen because Okta+Android+Cookies are unreliable.
          // Also addresses the unauthenticated support defect
          await Get.find<SessionManagerService>().logout();
          nextScreenRoute = Routes.login;
        }
      } else {
        // Log out when we show the Login screen because Okta+Android+Cookies are unreliable.
        // Also addresses the unauthenticated support defect
        await Get.find<SessionManagerService>().logout();
        nextScreenRoute = Routes.valueScreens;
      }
    }

    return nextScreenRoute;
  }

  Future<UpdateTerms> isUpdateAvailable() async {
    String _appOS = "";
    if (Platform.isAndroid) {
      _appOS = "android";
    } else {
      _appOS = "ios";
    }

    final _version = await appVersion();
    final response = await DataHelperImpl.instance.apiHelper
        .getAppVersion({"platform": _appOS, "version": _version});
    return response.fold((error) {
      Log.error(error);
      return updateTerms;
    }, (success) async {
      if (success.data.mandatory != null || success.data.optional != null) {
        final model = success;
        final appMandateUpdateVersion = model.data.mandatory?.version;
        final optionalUpdateVersion = model.data.optional?.version;
        if (optionalUpdateVersion != _version) {
          updateTerms = UpdateTerms.optional;
        }
        if (appMandateUpdateVersion != _version) {
          updateTerms = UpdateTerms.mandatory;
        }
        if (updateTerms == UpdateTerms.updated) {
          Get.offAndToNamed(Routes.splash);
        }
        return updateTerms;
      } else {
        return updateTerms;
      }
    });
  }

  Future<String> appVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }
}
