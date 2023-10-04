import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/create_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/authentication_service.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/containers/loading_container.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreateProfileVerifyEmail extends StatefulWidget {
  CreateProfileVerifyEmail({Key? key}) : super(key: key);

  @override
  _CreateProfileVerifyEmail createState() => _CreateProfileVerifyEmail();
}

class _CreateProfileVerifyEmail extends State<CreateProfileVerifyEmail> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  final _isLoadingController = PageState.DEFAULT.obs;
  bool get isLoading => _isLoadingController.value == PageState.LOADING;

  final createProfileController = Get.find<CreateProfileController>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final controller = Get.find<CreateProfileController>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: LoadingContainer(
            loadingControllers: [_isLoadingController],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getHorizontalBar(),
                _getCancelButton().paddingOnly(right: 16),
                const SizedBox(height: 32),
                emailVerifyTitleText("Please verify your email account")
                    .paddingAll(6),
                Text("We sent you a code to",
                    style: TextStyle(
                      fontSize: 16,
                    )).paddingAll(16),
                _getEmailAddress(controller).paddingAll(16),
                _getOtpView(screenSize, controller)
                    .paddingOnly(top: 20, left: 20, right: 20),
                _getResendCodeView().paddingAll(16),
                SizedBox(height: GlorifiValues.margin),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHorizontalBar() {
    return SizedBox(
      width: 135,
      height: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Divider(thickness: 5),
      ),
    ).marginOnly(top: 16);
  }

  Widget _getCancelButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel', style: TextStyle(color: profileRed)),
      ),
    );
  }

  Widget _getOtpView(Size screenSize, CreateProfileController controller) {
    return PinCodeTextField(
      autoFocus: true,
      autoDisposeControllers: true,
      appContext: context,
      length: 6,
      errorAnimationController: errorController,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          fieldWidth: 45.w,
          activeColor: otpPlaceholderColor,
          inactiveColor: otpPlaceholderColor,
          selectedColor: GlorifiColors.darkBlue,
          activeFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent),
      onChanged: Log.debug,
      onCompleted: _onCodeEnterComplete,
    );
  }

  Widget _getEmailAddress(CreateProfileController controller) {
    final width = MediaQuery.of(context).size.width - 60.0;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            controller.emailController.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: darkBlue),
          ),
        ),
      ),
    );
  }

  Widget _getResendCodeView() {
    final controller = Get.find<CreateProfileController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't get the code?",
          style: TextStyle(
            fontSize: 16,
            color: darkBlue,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Log.debug("Resend button clicked");
            controller.sendOtp();
          },
          child: Text(
            "Resend",
            style: TextStyle(
              fontSize: 16,
              color: darkBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  _onCodeEnterComplete(String otpValue) async {
    _isLoadingController(PageState.LOADING);
    try {
      AuthenticationService _authService = AuthenticationService();
      var _resp = await _authService.verifyOtp(email: createProfileController.email, otp: otpValue);
      if (_resp["success"] == true) {
        Get.toNamed(Routes.createPassword);
      } else {
        errorController.add(ErrorAnimationType.shake);
      }
    } catch (e) {
      Log.error(e);
      errorController.add(ErrorAnimationType.shake);
    }
    _isLoadingController(PageState.DEFAULT);
  }
}
