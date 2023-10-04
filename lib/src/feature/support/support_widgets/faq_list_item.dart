import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class FaqListItemWidget extends StatelessWidget {
  final Function? onTap;
  final String? label;
  final Color textColor;
  final TextStyle? textStyle;
  final AdaptiveSizingInfo? sizingInfo;

  const FaqListItemWidget({
    Key? key,
    this.onTap,
    this.label,
    this.textColor: GlorifiColors.black,
    this.textStyle,
    this.sizingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ripple(
          onTap: () => onTap!(),
          rippleRadius: 8.r,
          rippleColor: Colors.grey.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: sizingInfo!.isDesktop ? 8.h : 0,
                    horizontal: sizingInfo!.isDesktop ? 4.w : 0,
                  ),
                  child: Text(
                    label!,
                    textAlign: TextAlign.start,
                    style: textStyle ??
                        smallRegular16Primary(
                          color: textColor,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: GlorifiColors.cornflowerBlue,
                  size: 15.h,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 7.h,
          ),
          child: Divider(
            height: sizingInfo!.isDesktop ? 0 : 16.h,
            color: GlorifiColors.greyBgColor,
          ),
        )
      ],
    );
  }
}
