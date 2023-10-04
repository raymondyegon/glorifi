import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ContentTile extends StatelessWidget {
  ContentTile(
      {Key? key,
      required this.asset,
      required this.title,
      this.progress,
      this.showProgress = false,
      this.subTitle,
      required this.onTap,
      this.progressColor = GlorifiColors.bloodOrange,
      this.showArrow = true,
      this.arrowColor = GlorifiColors.bloodOrange,
      this.isLoading = "",
      this.backgroundColor = GlorifiColors.white})
      : super(key: key);

  final String asset, title;
  final String? subTitle, progress;
  final VoidCallback onTap;
  final bool showProgress;
  Color progressColor;
  final bool showArrow;
  Color arrowColor;
  final String isLoading;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: GlorifiColors.black.withOpacity(.10),
            blurRadius: 55,
            offset: Offset(0, 0),
          ),
        ],
        color: backgroundColor,
      ),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
          child: Row(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                asset,
                height: 24.h,
                width: 24.w,
                color: GlorifiColors.midnightBlue,
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
                      style: captionBold14Primary(
                          color: GlorifiColors.blueMidnightBlue),
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
                            style: smallRegular16Primary(
                                color: GlorifiColors.darkGrey),
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
                  title == isLoading ? Container(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(),
                  ) : Icon(
                          showArrow ? Icons.arrow_forward_ios : null,
                    color: arrowColor,
                    size: 18.h,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
