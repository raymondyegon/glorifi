import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class ContactSupportCategoryItem extends StatelessWidget {
  final String title;
  final Function() onTap;

  const ContactSupportCategoryItem({
    Key? key,
    this.title: '',
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 56.h,
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: GlorifiColors.black.withOpacity(0.10),
            blurRadius: 14,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Ripple(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: captionBold14Primary(
                  color: GlorifiColors.ebonyBlue,
                ),
              ),
            ),
            SvgPicture.asset(
              GlorifiAssets.forwardArrow,
              color: GlorifiColors.darkBlue,
              height: 14.0.sp,
              width: 8.0.sp,
              fit: BoxFit.contain,
            ).paddingOnly(right: 5.w),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    ).paddingOnly(bottom: 16.0.h);
  }
}
