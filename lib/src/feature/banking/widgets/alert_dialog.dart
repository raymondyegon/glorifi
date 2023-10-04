import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

Future<void> glorifiAlertDialog(
    String title, String message, String actionButtonText) async {
  return showDialog<void>(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        actionsPadding: EdgeInsets.only(bottom: 24.h),
        title: Text(
          title,
          style: headlineRegular31Secondary(color: GlorifiColors.midnightBlue),
        ),
        content: Text(
          message,
          style: captionRegular14Primary(color: GlorifiColors.midnightBlue),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          PrimaryButton(
              title: actionButtonText,
              width: 294.w,
              height: 64.h,
              primaryColor: GlorifiColors.primaryDarkButtonColor,
              textColor: GlorifiColors.primaryDarkButtonTextColor,
              onTap: () => Navigator.pop(context)),
        ],
      );
    },
  );
}
