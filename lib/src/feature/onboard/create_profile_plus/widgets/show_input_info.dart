import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

void showInfoDialog(
    BuildContext context, String infoTitle, String infoMessage) async {
  return showDialog(
      context: context,
      builder: (dialogContext) {
        return AdaptiveBuilder(builder: (context, sizingInfo) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            content: Container(
              width: 416.w,
              margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 75.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(infoTitle, style: bodyBold18Primary()),
                  SizedBox(height: 15.h),
                  Text(
                    infoMessage,
                    style: bodyRegular18Primary(
                      color: GlorifiColors.bgDarkGrey,
                    ).copyWith(height: 2),
                  ),
                  SizedBox(height: 35.h),
                  Row(
                    mainAxisAlignment: sizingInfo.isDesktop
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      PrimaryDarkButton(
                        title: "Got it!",
                        width: sizingInfo.isDesktop
                            ? 416.w
                            : sizingInfo.isTablet
                                ? 358.w
                                : null,
                        onTap: () {
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

void showBottomSheetLog(
    BuildContext context, String infoTitle, String infoMessage) async {
  int time = 0;
  FocusNode? node;
  if (WidgetsBinding.instance!.window.viewInsets.bottom > 0.0) {
    node = FocusManager.instance.primaryFocus;
    FocusManager.instance.primaryFocus?.unfocus();
    time = 150;
  }
  await Future.delayed(Duration(milliseconds: time)).then((value) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 21.h, bottom: 19.h),
              height: 5.h,
              width: 134.w,
              decoration: BoxDecoration(
                color: GlorifiColors.black,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            Text(
              infoTitle,
              style: bodyBold18Primary(color: GlorifiColors.textColorBlack),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 22.w),
              child: Text(
                infoMessage,
                style: bodyRegular18PrimaryWithLineHeight(
                  color: GlorifiColors.textColorBlack,
                  lineHeight: 1.78,
                ),
              ),
            ),
            PrimaryDarkButton(
              title: "Got it!",
              height: 53.h,
              width: 1.sw,
              avoidShadow: true,
              onTap: () {
                Navigator.of(context).pop();
              },
            ).paddingSymmetric(horizontal: 16.w, vertical: 30.h),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
      ),
    ).then((value) {
      FocusScope.of(context).requestFocus(node);
    });
  });
}
