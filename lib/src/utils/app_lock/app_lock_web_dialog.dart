import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_web_controller.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class AppLockWebDialog extends GetView<AppLockWebController> {
  AppLockWebDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (BuildContext dialogContext, sizingInfo) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        content: Padding(
          padding: sizingInfo.isTablet || sizingInfo.isDesktop
              ? EdgeInsets.symmetric(vertical: 40.h, horizontal: 100.w)
              : EdgeInsets.all(40.h),
          child: _pageContent(sizingInfo, context),
        ),
      );
    });
  }

  _pageContent(AdaptiveSizingInfo sizingInfo, BuildContext context) {
    bool isDesktopOrTablet = sizingInfo.isDesktop || sizingInfo.isTablet;

    return Column(
      crossAxisAlignment: isDesktopOrTablet
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Session Timeout",
          textAlign: isDesktopOrTablet ? TextAlign.center : TextAlign.start,
          style: headlineRegular31Secondary(
            color: GlorifiColors.midnightBlue,
          ),
        ).marginOnly(top: !sizingInfo.isNativeMobile ? 0 : 70.h),
        SizedBox(
          width: isDesktopOrTablet ? 300.w : null,
          child: Text(
            "Your session will be expire soon. You will be logged out automatically after your session expires. If you want to continue this session click continue.",
            textAlign: isDesktopOrTablet ? TextAlign.center : TextAlign.start,
            style: smallRegular16Primary(
              color: GlorifiColors.greyProfile,
            ),
          ),
        ).marginOnly(top: 19.h),
        SizedBox(
          width: isDesktopOrTablet ? 300.w : null,
          child: Obx(
            () => Text(
              "You will be logged out in ${controller.remainingTime} seconds",
              textAlign: isDesktopOrTablet ? TextAlign.center : TextAlign.start,
              style: smallBold16Primary(
                color: GlorifiColors.greyProfile,
              ),
            ),
          ),
        ).marginOnly(top: 32.h),
        _getButtons(sizingInfo).marginOnly(top: 32.h),
      ],
    );
  }

  Widget _getButtons(AdaptiveSizingInfo sizingInfo) {
    bool isDesktopOrTablet = sizingInfo.isDesktop || sizingInfo.isTablet;

    return Row(
      children: [
        Expanded(
          child: Obx(
            () => GlorifiOutlinedButton(
              title: "Logout",
              hasRightArrow: true,
              height: 58,
              onTap: controller.pageState == PageState.LOADING
                  ? () {}
                  : controller.logout,
            ),
          ),
        ),
        SizedBox(width: 24.h),
        Expanded(
          child: Obx(
            () => PrimaryDarkButton(
              title: "Continue",
              hasRightArrow: true,
              onTap: controller.continueSession,
              height: 58,
              isLoading: controller.pageState == PageState.LOADING,
              iconColor: GlorifiColors.lightBlue,
            ),
          ),
        ),
      ],
    );
  }
}
