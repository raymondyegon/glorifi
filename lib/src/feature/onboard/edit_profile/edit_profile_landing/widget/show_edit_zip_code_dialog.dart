import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_zip_code/controllers/edit_zip_code_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

import 'change_zip_code_success_dialog.dart';

Future showEditZipCodeDialog(
    BuildContext context, EditZipCodeController zipCodeController) {
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
                  Text('ZIP Code', style: bodyBold18Primary()),
                  SizedBox(height: 15.h),
                  _getZipCodeInputField(zipCodeController),
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
                          zipCodeController.zipOnlineValidationController(true);

                          bool? isZipValidOnline =
                              await zipCodeController.isZipCodeValidByOnline();

                          if (isZipValidOnline != null && isZipValidOnline) {
                            bool isSuccessfullyUpdated =
                                await zipCodeController.updateZipCode();
                            if (isSuccessfullyUpdated) {
                              Navigator.pop(context);
                              changeZipCodeSuccessDialog(context);
                            }
                          }
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

Widget _getZipCodeInputField(
  EditZipCodeController zipCodeController,
) {
  return TextFormField(
    inputFormatters: [DisableEmojiInputFilter.getDisableEmojiInputFilter()],
    autofocus: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.number,
    maxLength: 5,
    validator: (value) {
      if (!zipCodeController.isZipCodeValid) {
        if (zipCodeController.zipController.text.isEmpty) {
          return 'ZIP Code is required';
        } else {
          return 'Please enter a valid ZIP Code';
        }
      }
      return null;
    },
    style: TextStyle(color: GlorifiColors.textFieldTextColor),
    controller: zipCodeController.zipController,
    decoration: InputDecoration(
      enabledBorder: _border(),
      border: normalBorder(),
      focusedBorder: _border(),
      errorBorder: errorBorder(),
      counterText: '',
      //hide max_length count from bottom of TextFormField
      hintText: '90210',
      hintStyle: formInput(
        color: GlorifiColors.silver,
      ),
    ),
    onChanged: (value) {
      !zipCodeController.isZipCodeValid;
    },
  );
}

InputBorder _border({Color color = GlorifiColors.bermudaGray}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1),
    borderRadius: BorderRadius.circular(8),
  );
}
