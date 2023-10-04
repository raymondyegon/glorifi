import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class BiometricPermissionDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Function()? onConfirm;
  final Function()? onCancel;

  const BiometricPermissionDialog({
    Key? key,
    this.title = "Do you want to allow “GloriFi” to use Face ID?",
    this.content =
        "GloriFi has gone passwordless for your security. You must allow to continue.",
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget titleWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      margin: EdgeInsets.only(bottom: 8.h, top: 32.h),
      child: Text(
        title.replaceAll("Use", "use"),
        textAlign: TextAlign.center,
        style: smallBold16Primary(color: GlorifiColors.black)
            .copyWith(fontSize: 17.sp),
      ),
    );

    final Widget contentWidget = content != null
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              content!,
              textAlign: TextAlign.center,
              style: xSmallRegular12Primary(color: GlorifiColors.black).copyWith(fontSize: 14.sp),
            ))
        : Container();

    final buttonTextStyle =
        smallRegular16Primary(color: GlorifiColors.azureRadiance)
            .copyWith(fontSize: 17);

    final dontAllowButton = TextButton(
        onPressed: () {
          onCancel?.call();
          Navigator.of(context).pop();
        },
        child: Text(
          "Don't Allow",
          style: buttonTextStyle,
        ));

    final allowButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          onConfirm?.call();
        },
        child: Text(
          "Allow",
          style: buttonTextStyle,
        ));


    return AlertDialog(
      backgroundColor: GlorifiColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r))),
      contentPadding: EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleWidget,
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: contentWidget,
          ),
          Container(
            color: GlorifiColors.black.withOpacity(0.2),
            height: 1.w,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(child: dontAllowButton),
                Container(
                  color: GlorifiColors.black.withOpacity(0.2),
                  width: 1.w,
                ),
                Expanded(child: allowButton),
              ],
            ),
          )
        ],
      ),
    );
  }
}
