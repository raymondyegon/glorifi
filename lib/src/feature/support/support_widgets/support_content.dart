import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class SupportContent extends StatelessWidget {
  final VoidCallback onTap;
  final String assetPath;
  final String label;
  final AdaptiveSizingInfo sizingInfo;

  SupportContent({
    Key? key,
    required this.assetPath,
    required this.label,
    required this.onTap,
    required this.sizingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64.h,
        margin: EdgeInsets.only(
          right: 0.w,
          bottom: sizingInfo.isDesktop
              ? 40.h
              : sizingInfo.isTablet
                  ? 28.h
                  : 16.h,
        ),
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: GlorifiColors.black.withOpacity(0.10),
              spreadRadius: 0,
              blurRadius: 15.r,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 15.w),
            SvgPicture.asset(
              assetPath,
              height: 24,
              width: 28,
              color: GlorifiColors.biscayBlue,
            ),
            SizedBox(width: 15.w),
            Text(
              label,
              style: smallSemiBold16Primary(color: GlorifiColors.darkBlue),
            )
          ],
        ),
      ),
    );
  }
}
