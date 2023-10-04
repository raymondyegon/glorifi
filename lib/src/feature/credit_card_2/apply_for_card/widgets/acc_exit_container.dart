import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class ACCExitContainer extends GetView<ACCController> {
  ACCExitContainer({
    Key? key,
    required this.title,
    this.subtitle,
    required this.ctaButtons,
    this.picture,
    this.topPadding = 250,
    this.isDarkMode = true,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final List<Widget> ctaButtons;
  final Widget? picture;
  final double topPadding;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: Container(
        padding: EdgeInsets.only(
          right: 24.w,
          left: 24.w,
          top: topPadding.h,
          bottom: 100.h,
        ),
        child: Column(
          children: [
            if (picture != null) picture!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: headlineRegular30Primary(color: getFontColor()),
                ).paddingOnly(bottom: 30.h),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: smallRegular16Primary(color: getFontColor()),
                  ),
              ],
            ),
            Spacer(),
            ...ctaButtons
          ],
        ),
      ),
    );
  }

  Color getBackgroundColor() {
    return isDarkMode ? GlorifiColors.blueMidnightBlue : GlorifiColors.greyF3;
  }

  Color getFontColor() {
    return isDarkMode ? GlorifiColors.white : GlorifiColors.gradientDarkBlue;
  }
}
