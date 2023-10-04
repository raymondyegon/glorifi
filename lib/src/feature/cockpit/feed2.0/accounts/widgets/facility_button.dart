import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class FacilityButton extends StatelessWidget {
  final String icon;

  final String label, subText;
  final int count;
  final VoidCallback onTap;

  const FacilityButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.subText,
    required this.onTap,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(
                  icon,
                  color: GlorifiColors.darkBlue,
                  width: 32.w,
                  height: 32.h,
                ),
                SizedBox(height: 26.h),
                Text(
                  label,
                  style: bodySemiBold18Primary(color: GlorifiColors.darkBlue),
                ),
                SizedBox(height: 47.h),
                Spacer(),
                count == 0
                    ? Icon(
                        Icons.add,
                        size: 18,
                        color: GlorifiColors.black,
                      )
                    : Text(
                        "$count",
                        style: headlineBold26Secondary(
                            color: GlorifiColors.midnightBlue),
                      ),
                SizedBox(height: 26.h),
                Text(
                  subText,
                  style: leadSemiBold24Primary(color: GlorifiColors.darkBlue),
                ),
              ],
            )),
      ),
    );
  }
}
