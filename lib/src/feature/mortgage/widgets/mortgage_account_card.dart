import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_sizing.dart';
import '../../../utils/glorifi_assets.dart';
import '../../../utils/glorifi_colors.dart';

class MortgageAccountCard extends StatelessWidget {
  const MortgageAccountCard({
    Key? key,
    required this.title,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required this.image,
    this.onTap,
    this.sizingInfo,
    this.showCompanyLLC = true,
    this.cardVisibility = true,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final CrossAxisAlignment crossAxisAlignment;
  final String image;
  final AdaptiveSizingInfo? sizingInfo;
  final bool showCompanyLLC;
  final bool cardVisibility;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: cardVisibility,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                height: 395.h,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 150.h,
                  padding: EdgeInsets.only(
                    top: 12.h,
                    bottom: 16.h,
                    left: 24.h,
                    right: 24.h,
                  ),
                  decoration: BoxDecoration(
                    color: GlorifiColors.darkBlueTint[700],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getLogoRow(),
                      SizedBox(height: 10.h),
                      Text(
                        title,
                        style: headlineRegular21Secondary(
                          color: GlorifiColors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      _getBottomView(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getLogoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          GlorifiAssets.glorifiLogo,
          width: 27.w,
        ),
        SizedBox(width: 8.w),
        Text(
          "GloriFi Mortgage",
          style: captionSemiBold14Primary(
            color: GlorifiColors.white,
          ),
        ),
      ],
    );
  }

  Widget _getBottomView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        showCompanyLLC ? Text(
          "Animo Mortgage Company LLC\nd/b/a GloriFi Mortgage // NMLS #2267438",
          maxLines: 2,
          style: smallRegular8(color: GlorifiColors.white),
        ) : const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Apply",
              style: captionBold14Primary(
                color: GlorifiColors.white,
              ),
            ),
            SizedBox(width: 12.w),
            SvgPicture.asset(
              GlorifiAssets.arrowRightLong,
              color: GlorifiColors.selectedIndicatorColor,
            ),
          ],
        ),
      ],
    );
  }
}
