import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_logos.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/glorifi_logos/glorifi_logos.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import '../../../font_style_global.dart';

class GlorifiCheckingCard extends StatelessWidget {
  const GlorifiCheckingCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.accountType,
    required this.onTap,
    this.cardFor,
  }) : super(key: key);

  final String accountType;
  final String subTitle;
  final String title;
  final String? cardFor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 120.h,
        // margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: RadialGradient(
              radius: 1.5,
              colors: cardFor == AccountType.SAVINGS.name
                  ? [GlorifiColors.cornflowerBlue, GlorifiColors.mediumBlue]
                  : [GlorifiColors.bloodOrange, GlorifiColors.red]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: headlineBold31Secondary(
                    color: GlorifiColors.white,
                  ),
                ),
                GloriFiLogos(
                  imageKey: GlorifiLogos.logoBrandMarkWhite,
                  width: 27.w,
                  height: 19.h,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  toBeginningOfSentenceCase(accountType.toLowerCase())!,
                  style: captionSemiBold14Primary(
                    color: GlorifiColors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  subTitle,
                  style: captionSemiBold14Primary(
                    color: GlorifiColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
