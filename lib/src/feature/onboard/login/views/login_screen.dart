import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/okta_login.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/feature/onboard/login/controllers/login_controller.dart';
import 'package:glorifi/src/feature/onboard/login/widget/login_create_account.dart';
import 'package:glorifi/src/feature/onboard/login/widget/login_forget_support.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/containers/gradient_overlay_container.dart';
import 'package:glorifi/src/widgets/containers/loading_container.dart';

import '../../../../font_style_global.dart';
import '../../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../../../utils/support/support_navigation_helper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  final emailKey = GlobalKey<FormFieldState>();
  final passKey = GlobalKey<FormFieldState>();

  LoginController get controller => Get.find<LoginController>();

  late StreamSubscription streamSubscription;

  @override
  void initState() {
    // controller.checkForUserBiometricSettings();
    streamSubscription = controller.loginErrorMsgStream.listen((event) {
      setState(() {
        _loginFormKey.currentState?.validate();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.cancelBiometricIfActive();
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return WillPopScope(
      onWillPop: () async => false,
      child: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return AdaptiveScaffold(
            backgroundColor: GlorifiColors.productsBgWhite,
            showSimpleAppBar: true,
            body: Stack(
              children: [
                _background(sizingInfo),
                SafeArea(
                  child: LoadingContainer(
                    loadingControllers: [controller.pageState],
                    child: Container(
                      padding: EdgeInsets.only(
                        top: GlorifiValues.padding,
                        left: GlorifiValues.padding,
                        right: GlorifiValues.padding,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 1024),
                          child: Form(
                            key: _loginFormKey,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: sizingInfo.isDesktop
                                      ? 496.w
                                      : sizingInfo.isTablet
                                          ? 380.w
                                          : sizingInfo.screenSize.width),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: sizingInfo.isTablet
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                                children: [
                                  if (sizingInfo.isNativeMobile ||
                                      sizingInfo.isWebMobile)
                                    _logo(),
                                  SizedBox(height: GlorifiValues.margin_44),
                                  sizingInfo.isDesktop
                                      ? const SizedBox()
                                      : const SizedBox(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: isKeyboardVisible
                                                  ? 0
                                                  : GlorifiValues.margin_80),
                                          SizedBox(
                                              height: GlorifiValues.margin),
                                          _emailField(),
                                          SizedBox(
                                              height: GlorifiValues.margin),
                                          _loginButton(context),
                                          SizedBox(
                                              height: GlorifiValues.margin),
                                          LoginCreateAccountWidget(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            onTap: _onTapCreateAccount,
                                          ),
                                          SizedBox(
                                              height: GlorifiValues.margin_80),
                                        ],
                                      ),
                                    ),
                                  ),
                                  isKeyboardVisible
                                      ? Container()
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  sizingInfo.isNativeMobile ||
                                                          sizingInfo.isWebMobile
                                                      ? GlorifiValues.padding
                                                      : 200.h),
                                          child:
                                              LoginForgetPasswordSupportWidget(
                                            onTapForgetPass: null,
                                            onTapSupport: ()=>_onTapSupport(sizingInfo),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
          // }
        },
      ),
    );
  }

  _onTapSupport(AdaptiveSizingInfo sizingInfo) {
    if(sizingInfo.isDesktop) {
      Get.toNamed(
        Routes.faqCategoriesListingScreen,
      );
    } else {
      SupportNavigationHelper.loadBottomSheet();
    }
  }

  _onTapCreateAccount() {
    Get.toNamed(Routes.createProfilePlus);
  }

  Widget _background(AdaptiveSizingInfo sizingInfo) {
    return Positioned.fill(
      child: GradientOverlayContainer(
        colors: [Color(0xFF03213D).withOpacity(0.9)],
        stops: [1],
        child: Image.asset(
          sizingInfo.isDesktop
              ? GlorifiAssets.loginDesktopBg
              : GlorifiAssets.loginBg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _logo() {
    return SvgPicture.asset(
      GlorifiAssets.logoWithDarkBg,
      width: 170.w,
    );
  }

  Widget _logInText() {
    return Text(
      TextConstants.login,
      style: headlineRegular28Secondary(
        color: GlorifiColors.white,
      ),
    );
  }

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        inputTitleText(TextConstants.emailAddress),
        TextFormField(
          key: emailKey,
          inputFormatters: [
            DisableEmojiInputFilter.getDisableEmojiInputFilter(),
            // FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
          ],
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.go,
          style: TextStyle(color: profileTextColor),
          validator: controller.emailValidator,
          controller: controller.emailController,
          decoration: borderInputDecoration("email@example.com").copyWith(
            suffixIcon: Visibility(
              visible: !controller.isEmailEmpty,
              child: InputSuffixIcon(
                iconData: Icons.close,
                iconColor: profileTextColor,
                onTap: () {
                  controller.emailController.clear();
                  controller.forceHideEmailError = true;
                  emailKey.currentState?.validate();
                },
              ),
            ),
          ),
          onFieldSubmitted: (value) {
            _onLoginTap();
          },
          onChanged: (value) {
            setState(clearLoginErrorState);
          },
        ),
      ],
    );
  }

  clearLoginErrorState() {
    controller.clearLoginError();
    if (controller.forceHideEmailError == false) {
      controller.forceHideEmailError = true;
    }
    emailKey.currentState?.validate();
  }

  Widget _loginButton(BuildContext context) {
    return Obx(
      () => PrimaryButton(
        title: TextConstants.signIn,
        hasRightArrow: false,
        onTap: controller.pageState.value == PageState.LOADING
            ? null
            : _onLoginTap,
        width: Get.width,
        height: 64.h,
        primaryColor: GlorifiColors.white,
        textColor: GlorifiColors.midnightBlueColor,
        splashColor: GlorifiColors.midnightBlueColor,
        fontSize: 18.sp,
      ),
    );
  }

  _onLoginTap() {
    controller.forceHideEmailError = false;
    emailKey.currentState?.validate();

    bool isEmailValid = emailKey.currentState?.isValid == true;
    if (!isEmailValid) {
      return;
    }

    if (kIsWeb) {
      OktaLogin.present(controller.emailController.text);
    } else {
      controller.onTapLogin();
    }
  }

  InputDecoration borderInputDecoration(String hintText,
      {bool isSuccessBorder = false}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: textInputPlaceholderColor),
      labelStyle: TextStyle(color: profileTextColor),
      enabledBorder: normalBorder(),
      border: normalBorder(),
      focusedBorder: activeBorder(),
      errorBorder: errorBorder(),
      errorStyle: formHintOrError(
        color: Colors.red,
      ),
    );
  }
}
