import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/biometric_auth_mixin.dart';
import 'package:glorifi/src/controllers/local_auth_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/create_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/model/biometric_config.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/okta_login.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/create_profile_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/show_input_info.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/containers/loading_container.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';
import 'package:local_auth/local_auth.dart';

class CreateProfileSecure extends StatefulWidget {
  CreateProfileSecure({Key? key}) : super(key: key);

  @override
  _CreateProfileSecure createState() => _CreateProfileSecure();
}

class _CreateProfileSecure extends State<CreateProfileSecure>
    with BiometricAuthMixin {
  CreateProfileController get controller => Get.find<CreateProfileController>();
  BiometricType? _bioType;
  BiometricConfig biometricConfig = BiometricConfig(null);

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var _temp = await LocalAuth.getAvailableBiometrics();
    setState(() {
      _bioType = _temp;
      biometricConfig = BiometricConfig(_bioType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInformation) => LoadingContainer(
        loadingControllers: [controller.pageStateController],
        child: Stack(
          children: [
            Container(
              color: profileBackgroundColor,
              padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 0),
              child: CreateProfileContainer(
                  hasPercentBar: false,
                  percent: 1,
                  title: TextConstants.create_profile_secure_title,
                  text: _getBiometricHints(),
                  child: (sizingInformation.isDesktop ||
                          sizingInformation.isTablet)
                      ? _webWidget(sizingInformation)
                      : _mobileWidget()),
            ),
            if (sizingInformation.isNativeMobile ||
                sizingInformation.isWebMobile)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _whyCantIUsePasswordWidget(sizingInformation),
                ),
              )
          ],
        ),
      ),
    );
  }



  String _getBiometricHints(){
    if(kIsWeb){
      return TextConstants.create_profile_secure_subtitle_web;
    }
    else if(Platform.isIOS && _bioType?.name == BiometricType.face.name){
      return TextConstants.create_profile_secure_subtitle_faceid;
    } else if(Platform.isAndroid && _bioType?.name == BiometricType.fingerprint.name){
      return TextConstants
          .create_profile_secure_subtitle_fingerprint;
    }
    return "";
  }

  Widget _mobileWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 80.h),
        SvgPicture.asset(
          biometricConfig.iconPath,
          height: 88.h,
          width: 88.w,
        ),
        PrimaryButton(
          title: biometricConfig.buttonTitle,
          fontSize: 18.sp,
          height: 64.h,
          textColor: GlorifiColors.midnightBlueColor,
          onTap: _onTapBiometricButton,
        ).paddingOnly(
          top: 30,
          left: 64.w,
          right: 64.w,
        ),
      ],
    );
  }

  Widget _webWidget(AdaptiveSizingInfo sizingInformation) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryButton(
          title: biometricConfig.buttonTitle,
          onTap: _onTapBiometricButton,
        ).paddingOnly(top: 30),
        SizedBox(
          height: 12.h,
        ),
        _whyCantIUsePasswordWidget(sizingInformation),
      ],
    );
  }

  _whyCantIUsePasswordWidget(AdaptiveSizingInfo sizingInfo) {
    return Container(
      margin: EdgeInsets.only(bottom: 21.h),
      child: Ripple(
        onTap: () => _onTapPasswordRestriction(sizingInfo),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
          ),
          child: Text(
            "Why can’t I use a password?",
            style: (sizingInfo.isNativeMobile || sizingInfo.isWebMobile)
                ? smallRegular16Primary(color: GlorifiColors.white)
                    .copyWith(decoration: TextDecoration.none)
                : smallBold16Primary(color: GlorifiColors.white)
                    .copyWith(decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }

  void _onTapPasswordRestriction(AdaptiveSizingInfo sizingInfo) {
    final dialogTitle =
        TextConstants.create_profile_secure_password_restriction_hint;
    final dialogContent =
        TextConstants.create_profile_secure_password_restriction_details;

    sizingInfo.isWebMobile || sizingInfo.isNativeMobile
        ? showBottomSheetLog(context, dialogTitle, dialogContent)
        : showInfoDialog(context, dialogTitle, dialogContent);
  }

  void _onTapBiometricButton() async {
    if (kIsWeb) {
      OktaLogin.present(controller.email);
      return;
    } else {
      try {
        bool _ = await LocalAuthentication().authenticate(
          localizedReason: "Verify it's you",
          biometricOnly: true,
          sensitiveTransaction: false,
          useErrorDialogs: true,
        );
        _proceedToLogin();
      } catch (e) {
        _proceedToLogin();
      }
    }
  }

  _proceedToLogin() async {
    controller.pageStateController(PageState.LOADING);
    // Handle edge cases in Android preserving cookies in Chrome after deleting and installing the app
    if (Platform.isAndroid) {
      await Get.find<SessionManagerService>().logout(navigateToLogin: false);
    }
    await controller.loginUsingOkta(
      controller.emailController.text,
      onLoginSuccess: () async {
        Get.offAllNamed(Routes.cockpit);
      },
      isNewAccount: true,
    );
    controller.pageStateController(PageState.DEFAULT);
  }
}
