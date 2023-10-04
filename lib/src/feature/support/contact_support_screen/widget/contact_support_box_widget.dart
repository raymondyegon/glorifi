import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

import '../../../../font_style_global.dart';

class ContactSupportBoxWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String asset;
  final String phoneNumber;
  final bool contactNumAvailable;
  final Color? boxColor;
  final Color? textColor;
  final TextStyle? titleStyle;
  final TextStyle? descStyle;
  final Function() onTap;

  const ContactSupportBoxWidget({
    Key? key,
    this.title: '',
    this.subTitle: '',
    required this.asset,
    this.contactNumAvailable: false,
    this.boxColor,
    this.textColor,
    this.phoneNumber = '',
    required this.onTap,
    this.titleStyle,
    this.descStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 1,
        color: GlorifiColors.white,
        shape: _getWidgetShape(),
        child: Ripple(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                asset,
                color: GlorifiColors.midnightBlue,
                height: 24.h,
                width: 24.w,
              ).paddingSymmetric(horizontal: 24.w),
              _getTextInformation(),
            ],
          ).paddingSymmetric(horizontal: 16.w, vertical: 32.h),
        ),
      ).paddingOnly(bottom: 24.h),
    );
  }

  Widget _getTextInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bodyBold18Primary(
            color: GlorifiColors.darkBlue,
          ),
        ).paddingOnly(bottom: 12.h),
        phoneNumber.isNotEmpty
            ? Text(
                phoneNumber,
                style: bodyRegular18Primary(
                  color: GlorifiColors.midnightBlue,
                ),
              ).paddingOnly(bottom: 12.h)
            : Container(),
        Text(
          subTitle,
          style: smallRegular16Primary(
            color: GlorifiColors.midnightBlue,
          ),
        ),
      ],
    );
  }

  RoundedRectangleBorder _getWidgetShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.sp),
      side: BorderSide(color: GlorifiColors.altoGrey, width: 0.5),
    );
  }
}
