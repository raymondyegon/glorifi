import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:permission_handler/permission_handler.dart';

Future showPermissionSettingsDialog(
    BuildContext context, String sourceTypeContent,
    {IconData? sourceImage}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 34.h),
                  sourceImage == null
                      ? SvgPicture.asset(
                          GlorifiAssets.camera,
                          width: 45.w,
                        )
                      : Icon(sourceImage,
                          size: 45.r, color: GlorifiColors.midnightBlue),
                  SizedBox(height: 18.h),
                  Text(
                    "Enable Access",
                    style: headlineRegular31Secondary(
                      color: GlorifiColors.darkBlueColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    sourceTypeContent,
                    textAlign: TextAlign.center,
                    style: captionRegular14Primary(
                      color: GlorifiColors.ebonyBlue,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  PrimaryButton(
                    onTap: () {
                      openAppSettings();
                      Navigator.of(dialogContext).pop();
                    },
                    height: 64.h,
                    width: Get.width,
                    title: TextConstants.updateInSettings,
                    textColor: GlorifiColors.white,
                    fontSize: 18.sp,
                    primaryColor: GlorifiColors.primaryButtonProgressColor,
                  ),
                  SizedBox(height: 10.h),
                  GlorifiOutlinedButton(
                    onTap: () => Navigator.of(dialogContext).pop(),
                    height: 64.h,
                    title: TextConstants.cancelText,
                    textColor: GlorifiColors.defaultGradientStartColor,
                    fontSize: 18.sp,
                    borderColor: GlorifiColors.selectedIndicatorColor,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
