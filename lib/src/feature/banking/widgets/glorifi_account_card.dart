import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_logos.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/glorifi_logos/glorifi_logos.dart';

import '../../../font_style_global.dart';

class GlorifiAccountCard extends StatelessWidget {
  const GlorifiAccountCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.accountType,
    required this.onTap,
    required this.image,
    required this.sizingInfo,
  }) : super(key: key);

  final String accountType;
  final String subTitle;
  final String title;
  final VoidCallback onTap;
  final String image;
  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          color: GlorifiColors.darkBlueTint[700],
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        child: Column(
          mainAxisAlignment: accountType == AccountType.NONE.name
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(
                    image,
                  ),
                ),
              ),
              height: sizingInfo.isDesktop
                  ? 350.h
                  : sizingInfo.isTablet
                      ? 450.h
                      : 200.h,
              //width: sizingInfo != null ? 493.h : double.infinity,
            ),
            SizedBox(
              height: sizingInfo.isDesktop ? 32.h : 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GloriFiLogos(
                        imageKey: GlorifiLogos.brandMarkBg,
                        width: 27.w,
                        height: 9.h,
                      ),
                      SizedBox(
                        width: 8.h,
                      ),
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: captionSemiBold14Primary(
                            color: GlorifiColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizingInfo.isDesktop
                        ? 20.h
                        : sizingInfo.isTablet
                            ? 20.h
                            : 8.h,
                  ),
                  Text(
                    subTitle,
                    maxLines: 2,
                    style: headlineRegular21Secondary(
                      color: GlorifiColors.white,
                    ),
                  ),
                  SizedBox(
                    height: sizingInfo.isDesktop
                        ? 50.h
                        : sizingInfo.isTablet
                            ? 50.h
                            : 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Open an Account',
                        style: captionBold14Primary(
                          color: GlorifiColors.white,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SvgPicture.asset(
                        "assets/images/arrow.svg",
                        width: 16.w,
                        color: GlorifiColors.selectedIndicatorColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizingInfo.isDesktop ? 50.h : 16.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
