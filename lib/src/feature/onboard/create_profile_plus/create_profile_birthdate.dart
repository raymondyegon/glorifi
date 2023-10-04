import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/create_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/create_profile_zip.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_constant.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_info.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/create_profile_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icons.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/show_input_info.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_base_widget.dart';

class CreateProfileBirthDate extends StatefulWidget {
  CreateProfileBirthDate({Key? key}) : super(key: key);

  @override
  _CreateProfileBirthDate createState() => _CreateProfileBirthDate();
}

class _CreateProfileBirthDate extends State<CreateProfileBirthDate> {
  final GlobalKey<FormState> _birthFormKey = GlobalKey();
  final controller = Get.find<CreateProfileController>();
  bool isButtonPressed = false;

  void _saveForm() {
    setState(() {
      isButtonPressed = true;
    });

    validateDate();
    if (!controller.haveDateError.value) {
      Get.to(() => CreateProfileZip());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return CreateProfileContainer(
        percent: 0.8,
        pageTitles: createProfileTitles,
        progressBarActiveTitle: createProfileTitles[3],
        title: CreateProfileInfo.dobScreenTitle,
        text: CreateProfileInfo.dobScreenSubtitle,
        child: Form(
          key: _birthFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBirthdayTextInputField(sizingInfo),
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

  Widget _getBirthdayTextInputField(sizingInfo) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: profileTextColor),
              keyboardType: TextInputType.number,
              controller: controller.dobController,
              decoration: InputDecoration(
                suffixIcon: controller.dobController.text.isNotEmpty
                    ? InputSuffixIcons(
                        suffixIcons: [
                          _inputClear(controller.dobController),
                          _inputInfo(sizingInfo).paddingOnly(right: 9)
                        ],
                      )
                    : _inputInfo(sizingInfo),

                labelText: "Birthday",
                hintText: "MM/DD/YYYY",
                labelStyle: TextStyle(color: textInputPlaceholderColor),
                floatingLabelStyle: TextStyle(color: profileTextColor),
                hintStyle: TextStyle(color: textInputPlaceholderColor),
                enabledBorder: controller.haveDateError.value
                    ? errorBorder()
                    : normalBorder(),
                border: normalBorder(),
                focusedBorder: controller.haveDateError.value
                    ? errorBorder()
                    : activeBorder(),
                errorBorder: errorBorder(),
              ),
              inputFormatters: [
                CardFormatter(sample: 'xx/xx/xxxx', separator: '/'),
                DisableEmojiInputFilter.getDisableEmojiInputFilter()
              ],
              onChanged: (value) {
                //final bool isValid = _birthFormKey.currentState!.validate();
                validateDate();
                setState(() {
                  !controller.dobValid;
                  isButtonPressed = false;
                });
              },
            ),
            if (controller.haveDateError.value)
              Container(
                margin: EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  controller.errorMessageDate.value,
                  style: formHintOrError(color: profileRed),
                ),
              )
          ],
        ));
  }

  validateDate() {
    if (!isButtonPressed) {
      controller.haveDateError.value = false;
      return null;
    }
    if (!controller.dobValid) {
      if (controller.dobController.text.isEmpty) {
        controller.haveDateError.value = true;
        controller.errorMessageDate.value = 'Birthday is required';
        return null;
      } else {
        controller.haveDateError.value = true;
        controller.errorMessageDate.value = 'Please enter a valid date';
        return null;
      }
    }

    controller.haveDateError.value = false;
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
          ? showBottomSheetLog(context, CreateProfileInfo.dobQueryHint,
              CreateProfileInfo.dobInfo)
          : showInfoDialog(context, CreateProfileInfo.dobQueryHint,
              CreateProfileInfo.dobInfo),
    );
  }
}
