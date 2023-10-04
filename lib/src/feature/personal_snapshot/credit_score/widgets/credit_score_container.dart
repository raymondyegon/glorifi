import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../../font_style_global.dart';
import '../../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../../../utils/glorifi_colors.dart';

class CreditScoreContainer extends StatelessWidget {
  const CreditScoreContainer({
    Key? key,
    required this.title,
    required this.subTitle,
    this.webTitle,
    required this.child,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String? webTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!sizingInfo.isNativeMobile) ...[
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1024),
                child: Text("$webTitle",
                    style: headlineBold30Secondary(
                      color: GlorifiColors.cornflowerBlue,
                    )),
              ).paddingSymmetric(
                  vertical: sizingInfo.isWebMobile ? 48.h : 64.h,
                  horizontal: sizingInfo.isDesktop
                      ? 200.w
                      : sizingInfo.isTablet
                          ? 32.w
                          : 24.w),
            ],
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1024),
              child: AdaptiveGrid(
                children: [
                  AdaptiveGridItem(
                    desktop: 60,
                    tablet: 100,
                    webMobile: 100,
                    nativeMobile: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (sizingInfo.isNativeMobile) SizedBox(height: 32.h),
                        Text(
                          title,
                          style: sizingInfo.isNativeMobile
                              ? headlineBold26Secondary(
                                  color: GlorifiColors.cornflowerBlue)
                              : headlineRegular37Secondary(
                                  color: GlorifiColors.cornflowerBlue),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          subTitle,
                          style: sizingInfo.isNativeMobile
                              ? smallRegular16Primary(
                                  color: GlorifiColors.midnightBlueColor)
                              : bodyRegular18Primary(
                                  color: GlorifiColors.midnightBlueColor),
                        ),
                        SizedBox(height: sizingInfo.isDesktop ? 34.h : 24.h),
                        child,
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ],
              ),
            ).paddingSymmetric(
                horizontal: sizingInfo.isDesktop
                    ? 200.w
                    : sizingInfo.isTablet
                        ? 126.w
                        : 24.w)
          ],
        );
      },
    );
  }
}
