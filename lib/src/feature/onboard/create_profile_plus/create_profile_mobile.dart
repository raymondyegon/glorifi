import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/create_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/create_profile_birthdate.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_constant.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_info.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/create_profile_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icons.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_button.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/show_input_info.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../../../font_style_global.dart';

class CreateProfileMobile extends StatefulWidget {
  CreateProfileMobile({Key? key}) : super(key: key);

  @override
  _CreateProfileMobile createState() => _CreateProfileMobile();
}

class _CreateProfileMobile extends State<CreateProfileMobile> {
  final GlobalKey<FormState> _mobileFormKey = GlobalKey();
  final controller = Get.find<CreateProfileController>();
  bool isButtonPressed = false;

  void _saveForm() {
    setState(() {
      isButtonPressed = true;
    });

    validatePhone();

    if (!controller.havePhoneError.value) {
      Get.to(() => CreateProfileBirthDate());
    }
  }

  showReasonBottomsheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("This is the reason we ask for mobile"),
            profileNextButton(context, "Got it!", Container(), () {
              Navigator.pop(context);
            })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return CreateProfileContainer(
        sizingInfo: sizingInfo,
        percent: 0.6,
        pageTitles: createProfileTitles,
        progressBarActiveTitle: createProfileTitles[2],
        title: CreateProfileInfo.phoneNumberScreenTitle,
        text: CreateProfileInfo.phoneNumberScreenSubtitle,
        child: Form(
          key: _mobileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getMobileTextInputField(sizingInfo),
              SizedBox(height: GlorifiValues.margin_32),
              PrimaryButton(
                height: 64.h,
                title: TextConstants.continueButton,
                fontSize: 18.sp,
                textColor: GlorifiColors.midnightBlueColor,
                hasRightArrow: true,
                onTap: _saveForm,
              ),
            ],
          ),
        ).paddingOnly(top: 30.h),
      );
    });
  }

  Widget _getMobileTextInputField(sizingInfo) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: profileTextColor),
              keyboardType: TextInputType.number,
              controller: controller.mobileController,
              inputFormatters: [
                CardFormatter(sample: 'xxx-xxx-xxxx', separator: '-'),
                DisableEmojiInputFilter.getDisableEmojiInputFilter()
              ],
              decoration: InputDecoration(
                labelText: "Mobile Number",
                labelStyle: TextStyle(color: textInputPlaceholderColor),
                floatingLabelStyle: TextStyle(color: profileTextColor),

                suffixIcon: controller.mobileController.text.isNotEmpty
                    ? InputSuffixIcons(
                        suffixIcons: [
                          _inputClear(controller.mobileController),
                          _inputInfo(sizingInfo).paddingOnly(right: 9)
                        ],
                      )
                    : _inputInfo(sizingInfo),
                enabledBorder: controller.havePhoneError.value
                    ? errorBorder()
                    : normalBorder(),
                border: normalBorder(),
                focusedBorder: controller.havePhoneError.value
                    ? errorBorder()
                    : activeBorder(),
                errorBorder: errorBorder(),
              ),
              onChanged: (value) {
                //final bool isValid = _mobileFormKey.currentState!.validate();
                validatePhone();
                setState(() {
                  !controller.mobileValid;
                  isButtonPressed = false;
                });
              },
            ),
            Obx(() => (controller.havePhoneError.value)
                ? Container(
                    margin: EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      controller.errorMessagePhone.value,
                      style: formHintOrError(color: profileRed),
                    ),
                  )
                : Container())
          ],
        ));
  }

  validatePhone() {
    if (!isButtonPressed) {
      controller.havePhoneError.value = false;
      return null;
    }
    if (!controller.mobileValid) {
      if (controller.mobileController.text.isEmpty) {
        controller.havePhoneError.value = true;

        controller.errorMessagePhone.value = 'Mobile number is required';
        return null;
      } else {
        controller.havePhoneError.value = true;

        controller.errorMessagePhone.value =
            'Please enter a valid mobile number';
        return null;
      }
    } else if (controller.mobileController.text.startsWith('0') || controller.mobileController.text.startsWith('1')) {
      controller.havePhoneError.value = true;
      controller.errorMessagePhone.value =
          'Please enter a valid mobile number';
      return null;
    }

    controller.havePhoneError.value = false;
    return null;
  }

  Widget _inputClear(TextEditingController controller) {
    return InputSuffixIcon(
      iconData: Icons.close,
      iconColor: profileTextColor,
      onTap: () => _onInputClear(controller),
    );
  }

  _onInputClear(TextEditingController controller) {
    controller.clear();
    setState(() {
      controller.text;
      isButtonPressed = false;
    });
  }

  Widget _inputInfo(sizingInfo) {
    return InputSuffixIcon(
      iconData: Icons.info_outline_rounded,
      iconColor: profileTextColor,
      onTap: () => sizingInfo.isWebMobile || sizingInfo.isNativeMobile
          ? showBottomSheetLog(context, CreateProfileInfo.phoneNumberQueryHint,
              CreateProfileInfo.phoneNumberInfo)
          : showInfoDialog(context, CreateProfileInfo.phoneNumberQueryHint,
              CreateProfileInfo.phoneNumberInfo),
    );
  }
}
