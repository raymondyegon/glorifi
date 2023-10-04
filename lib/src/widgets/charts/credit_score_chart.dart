import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/charts/widgets/chart_marker.dart';

class CreditScoreChart extends StatelessWidget {
  const CreditScoreChart({
    Key? key,
    this.creditScore,
    this.label,
    this.recentlyAddedPoints,
  }) : super(key: key);

  final int? creditScore;
  final int? recentlyAddedPoints;
  final String? label;

  final double chartSize = 245;
  final double markerSize = 26;
  final int defaultValue = 710;

  @override
  Widget build(BuildContext context) {
    ///smaller circle for marker path
    final radiusCorrelation = 6;

    Offset _calculateMarkerPosition() {
      //min angle math.pi / 360 * (-180)
      //max angle math.pi / 360 * 180
      //total range 360
      //credit score 300 - 850
      //credit score total range 550

      int _creditScore = creditScore != null ? creditScore! : defaultValue;
      if (_creditScore < 300) {
        _creditScore = 300;
      } else if (_creditScore > 850) {
        _creditScore = 850;
      }

      final double percentage = (_creditScore - 300) / 5.5;
      final double myInterval = 360 * (percentage / 100);
      final double radians = math.pi / 360 * (-180 + myInterval);
      final double r = chartSize / 2 - radiusCorrelation;
      return Offset(r + r * math.sin(radians) - markerSize / 2,
          r - r * math.cos(radians) - markerSize / 2);
    }

    return Center(
      child: Container(
        width: chartSize,
        height: chartSize,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: chartSize / 2,
                child: Image.asset(
                  'assets/images/credit_score_chart_stroke.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: chartSize / 1.118181818181818,
                height: chartSize / 1.118181818181818,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: GlorifiColors.productsBgWhite,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 55,
                      offset: Offset(0, 13),
                      color: GlorifiColors.black.withOpacity(0.15),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: chartSize / 1.57,
                height: chartSize / 1.57,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: GlorifiColors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 55,
                      offset: Offset(0, 13),
                      color: GlorifiColors.black.withOpacity(0.15),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 14,
                      ),
                      if (creditScore != null)
                        Text(
                          creditScore.toString(),
                          style: headlineBold52Secondary().copyWith(
                            color: GlorifiColors.cornflowerBlue,
                            fontWeight: FontWeight.w700,
                            height: 34.sp / 52.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      if (recentlyAddedPoints != null &&
                          recentlyAddedPoints! > 0)
                        Text(
                          '+$recentlyAddedPoints point${recentlyAddedPoints! > 1 ? 's' : ''}',
                          style: smallSemiBold16Primary().copyWith(
                              color: GlorifiColors.cornflowerBlue,
                              height: 20.sp / 16.sp),
                        ),
                      if (creditScore != null && label != null)
                        Text(
                          label!.capitalize!,
                          style: bodyBold18Primary().copyWith(
                              color: GlorifiColors.midnightBlueColor,
                              height: 32.sp / 18.sp),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: chartSize - radiusCorrelation * 2,
                width: chartSize - radiusCorrelation * 2,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: _calculateMarkerPosition().dy,
                      left: _calculateMarkerPosition().dx,
                      child: ChartMarker(
                        size: markerSize,
                        color: GlorifiColors.cornflowerBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DividerPainter extends CustomPainter {
  const DividerPainter({required this.radians});

  final double radians;

  @override
  void paint(Canvas canvas, Size size) {
    final double r = size.width / 2;
    Paint paint = Paint()
      ..color = GlorifiColors.white
      ..strokeWidth = 6;

    canvas.drawLine(Offset(r, r),
        Offset(r + r * math.sin(radians), r - r * math.cos(radians)), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
