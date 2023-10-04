import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ProductTile extends StatelessWidget {
  ProductTile(
      {Key? key,
      required this.asset,
      required this.title,
      required this.onTap,
      this.child})
      : super(key: key);

  final String asset, title;
  final VoidCallback onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: GlorifiColors.black.withOpacity(.10),
            blurRadius: 55,
            offset: Offset(0, 0),
          ),
        ],
        color: GlorifiColors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        asset,
                        height: 24.h,
                        width: 24.w,
                        color: GlorifiColors.darkBlue,
                      ),
                      SizedBox(
                        width: 14.h,
                      ),
                      Text(
                        title,
                        style: captionBold14Primary(
                            color: GlorifiColors.blueMidnightBlue),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: GlorifiColors.darkBlue,
                    size: 18.h,
                  )
                ],
              ),
            ),
          ),
          if (child != null) child!
        ],
      ),
    );
  }
}
