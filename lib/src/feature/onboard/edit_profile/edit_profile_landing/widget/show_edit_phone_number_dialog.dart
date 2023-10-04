import 'package:flutter/material.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_phone_number/controllers/edit_phone_number_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

Future showEditPhoneNumberDialog(BuildContext context,
    EditPhoneNumberController mobilecontroller, ProfileController controller) {
  return showDialog(
      context: context,
      builder: (dialogContext) {
        return AdaptiveBuilder(builder: (context, sizingInfo) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Container(
              width: 416.w,
              margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 75.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Phone Number", style: bodyBold18Primary()),
                  SizedBox(height: 15.h),
                  _getphoneNumberCodeInputField(mobilecontroller, controller),
                  SizedBox(height: 35.h),
                  Row(
                    mainAxisAlignment: sizingInfo.isDesktop
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      PrimaryDarkButton(
                        title: "Save",
                        width: sizingInfo.isDesktop
                            ? 416.w
                            : sizingInfo.isTablet
                                ? 358.w
                                : null,
                        onTap: () async {
                          bool edited = await mobilecontroller.editPhoneNumber(
                              mobilecontroller.phoneNumberController.text);
                          if (edited) {
                            controller.updateMobileNumber(
                                mobilecontroller.phoneNumberController.text);
                          }
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      });
}

Widget _getphoneNumberCodeInputField(
    EditPhoneNumberController mobilecontroller, ProfileController controller) {
  mobilecontroller.phoneNumberController.text =
      controller.userProfile.phoneNumber;
  return TextFormField(
    inputFormatters: [
      CardFormatter(sample: 'xxx-xxx-xxxx', separator: '-'),
      DisableEmojiInputFilter.getDisableEmojiInputFilter()
    ],
    autofocus: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.number,
    validator: (value) {
      if (!mobilecontroller.isphoneNumberCodeValid) {
        if (mobilecontroller.phoneNumberController.text.isEmpty) {
          return 'Mobile Number is required';
        } else {
          return 'Please enter a valid Mobile Number';
        }
      }
      return null;
    },
    style: TextStyle(color: GlorifiColors.textFieldTextColor),
    controller: mobilecontroller.phoneNumberController,
    decoration: InputDecoration(
      enabledBorder: _border(),
      border: normalBorder(),
      focusedBorder: _border(),
      errorBorder: errorBorder(),
      hintText: '###-###-####',
      hintStyle: formInput(
        color: GlorifiColors.silver,
      ),
    ),
    onChanged: (value) {
      !mobilecontroller.isphoneNumberCodeValid;
    },
  );
}

InputBorder _border({Color color = GlorifiColors.bermudaGray}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1),
    borderRadius: BorderRadius.circular(8),
  );
}
