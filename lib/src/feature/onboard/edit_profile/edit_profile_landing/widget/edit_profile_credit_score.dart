import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';

/*
class EditProfileCreditScore extends StatefulWidget {
  const EditProfileCreditScore({
    Key? key,
    required this.onTap,
    this.isMobile = false,
    this.creditScoreEnabled = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isMobile;
  final bool creditScoreEnabled;

  @override
  _EditProfileCreditScoreState createState() => _EditProfileCreditScoreState();
}
*/

class EditProfileCreditScore extends StatelessWidget {
  const EditProfileCreditScore({
    Key? key,
    required this.onTap,
    this.isMobile = false,
    this.creditScoreEnabled = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isMobile;
  final bool creditScoreEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TextConstants.creditScore,
              style: smallBold16Primary(
                color: GlorifiColors.midnightBlue,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                !creditScoreEnabled
                    ? Icons.error_outline
                    : Icons.check_circle_outlined,
                size: 20,
                color: !creditScoreEnabled
                    ? GlorifiColors.redError
                    : GlorifiColors.denimGreen,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        InkWell(
          onTap: onTap,
          child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 26.h,
                horizontal: 20.w,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: GlorifiColors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    GlorifiAssets.creditScoreMedal,
                    width: 24.sp,
                    height: 24.sp,
                    color: creditScoreEnabled
                        ? GlorifiColors.denimGreen
                        : GlorifiColors.cornflowerBlue,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          !creditScoreEnabled
                              ? TextConstants.getYourFreeCreditScore
                              : TextConstants.myCreditScore,
                          style: smallRegular16PrimaryBold(
                            color: !creditScoreEnabled
                                ? GlorifiColors.cornflowerBlue
                                : GlorifiColors.denimGreen,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          !creditScoreEnabled
                              ? TextConstants.weAreRetrievingYourCreditScore
                              : TextConstants.youCanNowViewYourCreditScore,
                          style: smallRegular16Primary(
                            color: GlorifiColors.ebonyBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
