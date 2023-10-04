import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {Key? key,
      required this.mainAxisAlignment,
      required this.height,
      required this.image,
      required this.onTap,
      this.padding,
      this.borderRadius = 8,
      required this.bannerMainText,
      required this.bannerSubText})
      : super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final double height, borderRadius;
  final String image;
  final EdgeInsets? padding;
  final String bannerMainText, bannerSubText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          height: height,
          padding: padding ?? EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          GlorifiColors.defaultGradientStartColor
                              .withOpacity(0.2),
                          GlorifiColors.defaultGradientStartColor
                              .withOpacity(0.5),
                          GlorifiColors.defaultGradientStartColor
                              .withOpacity(0.9),
                          GlorifiColors.defaultGradientStartColor,
                          GlorifiColors.defaultGradientStartColor,
                        ],
                        stops: [0.2, 0.4, 0.6, 1, 1],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(20.0.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              GlorifiAssets.glorifiLogo,
                              height: 9,
                              width: 27,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              "GloriFi Insurance",
                              style: captionSemiBold14Primary(
                                color: GlorifiColors.white,
                              ).copyWith(height: 1.5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          bannerMainText,
                          style: headlineRegular26Secondary(
                            color: GlorifiColors.white,
                          ).copyWith(height: 1.5),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Row(
                          mainAxisAlignment: mainAxisAlignment,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              bannerSubText,
                              style: captionBold14Primary(
                                color: GlorifiColors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SvgPicture.asset(
                              "assets/images/arrow.svg",
                              color: GlorifiColors.selectedIndicatorColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
