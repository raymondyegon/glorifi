import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class InsuranceCategoryTile extends StatelessWidget {
  const InsuranceCategoryTile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: GlorifiColors.black.withOpacity(0.10),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            color: GlorifiColors.blueMidnightBlue,
          ),
          SizedBox(
            width: 8.h,
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: captionBold14Primary(
                color: GlorifiColors.blueMidnightBlue,
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: GlorifiColors.darkBlueColor,
            size: 18.h,
          ),
        ],
      ),
    );
  }
}
