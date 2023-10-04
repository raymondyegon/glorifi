import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class ContactSupportItem extends StatelessWidget {
  final String title;
  final String assetIcon;
  final Function() onTap;

  const ContactSupportItem({
    Key? key,
    this.title: '',
    required this.onTap,
    required this.assetIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 64.h,
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: GlorifiColors.black.withOpacity(0.10),
            blurRadius: 55,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Ripple(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetIcon,
              color: GlorifiColors.gradientDarkBlue,
              height: 20.0.h,
              width: 19.0.w,
              fit: BoxFit.contain,
            ).paddingOnly(right: 17.w),
            Expanded(
              child: Text(
                title,
                style: bodyBold18Primary(
                  color: GlorifiColors.biscayBlue,
                ),
              ),
            ),
          ],
        ).paddingSymmetric(
          horizontal: 18.w,
        ),
      ),
    ).paddingOnly(bottom: 16.0.h);
  }
}
