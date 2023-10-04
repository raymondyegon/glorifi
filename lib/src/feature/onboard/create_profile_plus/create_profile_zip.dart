import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/create_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_constant.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_info.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/checkable_text.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/create_profile_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icons.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/show_input_info.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/terms_and_condition_text.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_base_widget.dart';
import 'create_profile_secure.dart';
import 'create_profile_verfication_failed.dart';

class CreateProfileZip extends StatefulWidget {
  CreateProfileZip({Key? key}) : super(key: key);

  @override
  _CreateProfileZip createState() => _CreateProfileZip();
}

class _CreateProfileZip extends State<CreateProfileZip> {
  final CreateProfileController controller =
      Get.find<CreateProfileController>();
  final GlobalKey<FormState> _zipFormKey = GlobalKey();
  bool _termsFlag = false;
  bool isButtonPressed = false;

  bool get isTermsErrorEligible => !_termsFlag && isButtonPressed;

  listenToVerifyMemberStream() {
    controller.verifyMemberStream.listen((status) {
      setState(() {
        controller.loading = false;
      });
      switch (status) {
        case VerifyMember.accepted:
          _moveToSecureProfilePage();
          break;
        case VerifyMember.denied:
          _moveToErrorPage();
          break;
        default:
          {}
      }
    });
  }

  _moveToSecureProfilePage() async {
    await Future.delayed(Duration(seconds: 1));
    if (controller.redirectArgument.isNotEmpty) {
      //implement the redirection to blend
    } else {
      Get.off(() => CreateProfileSecure());
    }
  }

  _moveToErrorPage() {
    Get.off(() => CreateProfileVerificationFailed());
  }

  void _saveForm() async {
    setState(() {
      isButtonPressed = true;
    });
    controller.zipOnlineValidationController(true);
    validateZip();

    if (!_termsFlag) {
      return;
    }

    if (!controller.haveZipError.value) {
      setState(() {
        controller.loading = true;
      });

      bool? isZipValidOnline = await controller.isZipCodeValidByOnline();

      setState(() {
        _zipFormKey.currentState!.validate();
      });

      if (isZipValidOnline != null && isZipValidOnline) {
        controller.verify();
        listenToVerifyMemberStream();
        // Get.to(() => CreateProfileVerify());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return CreateProfileContainer(
        percent: 1,
        title: CreateProfileInfo.zipScreenTitle,
        text: CreateProfileInfo.zipScreenSubtitle,
        pageTitles: createProfileTitles,
        progressBarActiveTitle: createProfileTitles.last,
        child: Form(
          key: _zipFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getZipCodeInputField(sizingInfo),
              const SizedBox(height: GlorifiValues.margin_32),
              _termsAndCondition(),
              const SizedBox(height: GlorifiValues.margin),
              _getTermsAndConditionErrorWidget().marginOnly(left: 40.w),
              SizedBox(height: GlorifiValues.margin_32),
              PrimaryButton(
                height: 64.h,
                title: TextConstants.submit,
                textColor: GlorifiColors.midnightBlueColor,
                fontSize: 18.sp,
                onTap: _saveForm,
                isLoading: controller.loading,
              ),
              SizedBox(height: 40),
              _userDiscernment()
            ],
          ),
        ).paddingOnly(top: 30.h),
      );
    });
  }

  Widget _getZipCodeInputField(sizingInfo) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              inputFormatters: [
                DisableEmojiInputFilter.getDisableEmojiInputFilter(),
                LengthLimitingTextInputFormatter(5)
              ],
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: profileTextColor),
              keyboardType: TextInputType.number,

              controller: controller.zipController,
              decoration: InputDecoration(
                suffixIcon: controller.zipController.text.isNotEmpty
                    ? InputSuffixIcons(
                        suffixIcons: [
                          _inputClear(),
                          _inputInfo(sizingInfo).paddingOnly(right: 9),
                        ],
                      )
                    : _inputInfo(sizingInfo),
                enabledBorder: controller.haveZipError.value
                    ? errorBorder()
                    : normalBorder(),
                border: normalBorder(),
                focusedBorder: controller.haveZipError.value
                    ? errorBorder()
                    : activeBorder(),
                errorBorder: errorBorder(),
                labelText: 'ZIP Code',
                labelStyle: TextStyle(color: textInputPlaceholderColor),
                floatingLabelStyle: TextStyle(color: profileTextColor),
              ),
              onChanged: (value) {
                validateZip();
                setState(() {
                  !controller.isZipCodeValid;
                  isButtonPressed = false;
                });
              },
            ),
            if (controller.haveZipError.value)
              Container(
                margin: EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  controller.errorMessageZip.value,
                  style: formHintOrError(color: profileRed),
                ),
              )
          ],
        ));
  }

  validateZip(){

    if (!isButtonPressed) {
      controller.haveZipError.value=false;
      return null;
    }
    if (!controller.isZipCodeValid) {
      controller.loading = false;
      if (controller.zipController.text.isEmpty) {
        controller.haveZipError.value=true;
        controller.errorMessageZip.value= 'ZIP Code is required';
        return null;
      } else {
        controller.haveZipError.value=true;
        controller.errorMessageZip.value= 'Please enter a valid ZIP code';
        return null;
      }
    }

    controller.haveZipError.value=false;
    return null;

  }

  Widget _termsAndCondition() {
    return CheckableText(
      uncheckedBorderColor:
          isTermsErrorEligible ? GlorifiColors.lightRed : profileIconColor,
      text: TermsAndConditionText(),
      isChecked: _termsFlag,
      onCheckChange: (value) => setState(() {
        _termsFlag = value!;
      }),
    );
  }

  Widget _inputClear() {
    return InputSuffixIcon(
      iconData: Icons.close,
      iconColor: profileTextColor,
      onTap: _onInputClear,
    );
  }

  _onInputClear() {
    controller.zipController.clear();
    setState(() {
      controller.zipController.text;
      isButtonPressed = false;
    });
  }

  Widget _inputInfo(sizingInfo) {
    return InputSuffixIcon(
      iconData: Icons.info_outline_rounded,
      iconColor: profileTextColor,
      onTap: () => sizingInfo.isWebMobile || sizingInfo.isNativeMobile
          ? showBottomSheetLog(context, CreateProfileInfo.zipQueryHint,
              CreateProfileInfo.zipInfo)
          : showInfoDialog(context, CreateProfileInfo.zipQueryHint,
              CreateProfileInfo.zipInfo),
    );
  }

  Widget _getTermsAndConditionErrorWidget() {
    return Visibility(
      visible: isTermsErrorEligible,
      child: Text(
        'Please agree to Terms',
        style: formHintOrError(
          color: GlorifiColors.lightRed,
        ),
      ),
    );
  }

  Widget _userDiscernment() {
    return Text(
      TextConstants.userDiscernment,
      style: captionRegular14Primary(color: GlorifiColors.white),
    );
  }
}
