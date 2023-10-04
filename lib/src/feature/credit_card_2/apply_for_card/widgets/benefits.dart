import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/shared/gf_webview.dart';

class Benefits extends StatelessWidget {
  final Color textColor;

  final Color iconColor;

  const Benefits({
    Key? key,
    required this.benefit,
    this.textColor = GlorifiColors.darkBlue,
    this.iconColor = GlorifiColors.darkBlue,
  }) : super(key: key);

  final String benefit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          GFWebview(
            pageTitle: 'Benefits',
            initialUrl: "https://www.glorifi.com",
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              benefit,
              style: captionBold14Primary(color: textColor),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
