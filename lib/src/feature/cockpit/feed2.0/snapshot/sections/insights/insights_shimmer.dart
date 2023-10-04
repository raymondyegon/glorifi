import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:shimmer/shimmer.dart';

class InsightsShimmer extends StatelessWidget {
  const InsightsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInformation) {
        bool isMobile = sizingInformation.isNativeMobile || sizingInformation.isWebMobile;
        return ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 0,
                left: isMobile ? 24.w : 0,
                right: isMobile ? 24.w : 0,
                bottom: 10,
              ),
              height: 500,
              child: Shimmer.fromColors(
                baseColor: Colors.white60,
                highlightColor: GlorifiColors.greyBgColor.withOpacity(
                  0.3,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 500,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 20,
                left: isMobile ? 24.w : 0,
                right: isMobile ? 24.w : 0,
              ),
              height: 500,
              child: Shimmer.fromColors(
                baseColor: Colors.white60,
                highlightColor: GlorifiColors.greyBgColor.withOpacity(
                  0.3,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
