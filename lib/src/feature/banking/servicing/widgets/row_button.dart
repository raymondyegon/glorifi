import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class RowButton extends StatelessWidget {
  RowButton({
    Key? key,
    required this.asset,
    required this.title,
    this.progress,
    this.showProgress = false,
    this.subTitle,
    required this.onTap,
    this.progressColor = GlorifiColors.lightBlue,
    this.arrowColor = GlorifiColors.lightBlue,
    this.showShadow = true,
    this.border,
    this.backgroundColor = GlorifiColors.white,
    this.textColor = GlorifiColors.cornflowerBlue,
    this.leadingIconColor = GlorifiColors.cornflowerBlue,
  }) : super(key: key);

  final String asset, title;
  final String? subTitle, progress;
  final VoidCallback onTap;
  final bool showProgress;
  final bool showShadow;
  final Border? border;
  Color progressColor;
  Color arrowColor;
  Color backgroundColor;
  Color textColor;
  Color leadingIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: border,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              color: GlorifiColors.black.withOpacity(.10),
              blurRadius: 55,
              offset: Offset(0, 0),
            ),
        ],
        color: backgroundColor,
      ),
      child: Ripple(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                asset,
                height: 24.h,
                width: 24.w,
                color: leadingIconColor,
              ),
              SizedBox(
                width: 14.h,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: captionBold14Primary(color: textColor),
                    ),
                    if (subTitle != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            subTitle!,
                            style: smallRegular16Primary(color: GlorifiColors.darkGrey),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              Row(
                children: [
                  if (showProgress && progress != null)
                    Padding(
                      padding: EdgeInsets.only(right: 15.0.w),
                      child: Text(
                        progress!,
                        style: captionSemiBold14Primary(color: progressColor),
                      ),
                    ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: arrowColor,
                    size: 18.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
