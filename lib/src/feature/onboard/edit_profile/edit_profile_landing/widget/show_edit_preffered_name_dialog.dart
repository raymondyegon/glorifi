import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_preferred_name/controllers/edit_preferred_name_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

import '../../../create_profile_plus/widgets/input_suffix_icons.dart';

Future showEditPreferredNameDialog(
    BuildContext context, EditPreferredNameController controller) {
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
                  Text('Preferred Name', style: bodyBold18Primary()),
                  SizedBox(height: 15.h),
                  _getPreferredNameInputField(controller),
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
                          bool isValid = controller.isPreferredNameValid();
                          if (isValid) {
                            bool isSuccessfullyUpdated =
                                await controller.updatePreferredName();
                            if (isSuccessfullyUpdated) {
                              Navigator.pop(context);
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

Widget _getPreferredNameInputField(
  EditPreferredNameController controller,
) {
  return TextFormField(
    autofocus: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    style: TextStyle(color: GlorifiColors.textFieldTextColor),
    keyboardType: TextInputType.text,
    validator: (value) {
      if (controller.preferredNameController.text.isEmpty) {
        return 'Please enter your preferred name.';
      }
      if (!controller.preferredNameValid) {
        return 'Please enter a valid preferred name';
      }
      return null;
    },
    controller: controller.preferredNameController,
    inputFormatters: [DisableEmojiInputFilter.getDisableEmojiInputFilter()],
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      hintText: "ie. Jake",
      hintStyle: formInput(
        color: GlorifiColors.silver,
      ),
      filled: true,
      fillColor: GlorifiColors.white,
      enabledBorder: _border(),
      border: normalBorder(),
      focusedBorder: _border(),
      errorBorder: errorBorder(),
    ),
    onChanged: (value) {
      !controller.preferredNameValid;
    },
  );
}

InputBorder _border({Color color = GlorifiColors.bermudaGray}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1),
    borderRadius: BorderRadius.circular(8),
  );
}
