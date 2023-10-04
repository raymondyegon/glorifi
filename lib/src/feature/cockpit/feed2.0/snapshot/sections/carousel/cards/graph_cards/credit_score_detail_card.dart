import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_detail_screen_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_top_part.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/snapshot_carousel_card.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/credit_score_gauge.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';
import 'package:intl/intl.dart';
import 'dart:math';

// import 'package:syncfusion_flutter_gauges/gauges.dart';

class CreditScoreDetailCard extends StatelessWidget {
  const CreditScoreDetailCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreditScoreDetailScreenController _creditScoreController =
        Get.put(CreditScoreDetailScreenController());

    return _creditScoreController.obx(
        (state) {
          int? _creditScoreChange =
              _creditScoreController.creditScoreModel.value.data?.creditDelta !=
                      null
                  ? int.parse(_creditScoreController
                      .creditScoreModel.value.data!.creditDelta!)
                  : null;
          DateTime _asOfNow =
              _creditScoreController.creditScoreModel.value.data!.asOfDate;
          String sinceDate =
              "${_asOfNow.month}/${_asOfNow.day}/${_asOfNow.year}";
          DateTime _nextUpdate =
              DateTime(_asOfNow.day, _asOfNow.month + 1, _asOfNow.year);
          return Ripple(
            onTap: () => Get.toNamed(Routes.creditScoreDetailScreen),
            child: SnapshotCarouselCard(
              isGraph: true,
              topPart: CarouselCardTopPart(
                customContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Credit Score",
                          style: customGlorifiStyle(
                            color: GlorifiColors.white,
                            size: 22.sp,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        width: 400,
                        height: 200,
                        // alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Gauge
                            // SfRadialGauge(
                            //   axes: <RadialAxis>[
                            //     RadialAxis(
                            //       showLabels: false,
                            //       showTicks: false,
                            //       minimum: 300,
                            //       maximum: 850,
                            //       startAngle: 160,
                            //       endAngle: 20,
                            //       axisLineStyle: AxisLineStyle(
                            //         thickness: 0.15,
                            //         cornerStyle: CornerStyle.bothCurve,
                            //         thicknessUnit: GaugeSizeUnit.factor,
                            //         color: Color(0xFF1A3365),
                            //       ),
                            //       pointers: <GaugePointer>[
                            //         RangePointer(
                            //           enableAnimation: true,
                            //           value: _creditScoreController
                            //               .creditScoreModel
                            //               .value
                            //               .data!
                            //               .creditScore
                            //               .toDouble(),
                            //           width: 0.15,
                            //           sizeUnit: GaugeSizeUnit.factor,
                            //           gradient: SweepGradient(
                            //             colors: <Color>[
                            //               Color(0xFF29519F),
                            //               Color(0xFFB7C9EC)
                            //             ],
                            //             stops: <double>[0.25, 0.75],
                            //           ),
                            //           cornerStyle: CornerStyle.bothCurve,
                            //           // width: 25,
                            //         ),
                            //         MarkerPointer(
                            //           enableAnimation: true,
                            //           value: _creditScoreController
                            //                   .creditScoreModel
                            //                   .value
                            //                   .data!
                            //                   .creditScore
                            //                   .toDouble() -
                            //               12,
                            //           markerHeight: 15,
                            //           markerWidth: 15,
                            //           markerType: MarkerType.circle,
                            //           enableDragging: true,
                            //           color: Color.fromARGB(0, 9, 142, 203),
                            //           borderWidth: 2,
                            //           borderColor:
                            //               Color.fromARGB(255, 255, 255, 255),
                            //         ),
                            //       ],
                            //     )
                            //   ],
                            // ),

                            // Credit Score Center
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  'Credit Score',
                                  style: smallBold16Secondary(
                                      color: Color(0xFFCFD8E6)),
                                ),
                                Text(
                                  _creditScoreController
                                      .creditScoreModel.value.data!.creditScore
                                      .toString(),
                                  style: smallBold16Secondary(
                                      color: Color(0xFFCFD8E6)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "+${_creditScoreChange}pts",
                                  style: xSmallBold12Primary(
                                      color: Color(0xFF1AD35E)),
                                ),
                                Text(
                                  "Since ${sinceDate}",
                                  style: tinySemiBold10Primary(
                                      color: Color(0xFFA8B6CB)),
                                ),
                              ],
                            ),

                            // minimum label
                            Positioned(
                              left: 60,
                              bottom: 45,
                              child: Text(
                                '300',
                                style: TextStyle(
                                  fontFamily: 'Univers',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFCFD8E6),
                                ),
                              ),
                            ),

                            // maximum label
                            Positioned(
                              right: 60,
                              bottom: 45,
                              child: Text(
                                '850',
                                style: TextStyle(
                                  fontFamily: 'Univers',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFCFD8E6),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                svg: '',
                // svg: GlorifiAssets.medalIcon,
              ),
            ),
          );
        },
        onLoading: Container(
          margin: EdgeInsets.symmetric(vertical: 70, horizontal: 8),
          child: ShimmeryPlaceHolder(),
        ),
        onError: (_) {
          int? _creditScoreChange =
              _creditScoreController.creditScoreModel.value.data?.creditDelta !=
                      null
                  ? int.parse(_creditScoreController
                      .creditScoreModel.value.data!.creditDelta!)
                  : null;
          return SnapshotCarouselCard(
            isGraph: true,
            topPart: CarouselCardTopPart(
              customContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_creditScoreController
                            .creditScoreModel.value.data?.creditScore !=
                        null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Row(
                          children: [
                            Text(
                              '${_creditScoreController.creditScoreModel.value.data!.creditScore} Points',
                              style: leadRegular24Secondary(
                                  color: GlorifiColors.cornflowerBlue),
                            ),
                            SizedBox(width: 8.w),
                            if (_creditScoreChange != null &&
                                _creditScoreChange != 0)
                              _scoreChangeWidget(_creditScoreChange),
                          ],
                        ),
                      ),
                    if (_creditScoreController
                            .creditScoreModel.value.data?.asOfDate !=
                        null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          'As of ${DateFormat("M/d/yyyy").format(_creditScoreController.creditScoreModel.value.data!.asOfDate)}',
                          style: smallRegular16Primary(
                            color: GlorifiColors.midnightBlueColor,
                          ),
                        ),
                      ),
                    Text(
                      'There was an issue updating your credit. Check back later for your new score.',
                      style: smallRegular16Primary(
                        color: GlorifiColors.midnightBlueColor,
                      ),
                    ),
                  ]),
              svg: GlorifiAssets.alertCircle,
              svgColor: GlorifiColors.darkRed,
            ),
          );
        });
  }

  Widget _scoreChangeWidget(int change) {
    return Row(
      children: [
        Transform.rotate(
          angle: change < 0 ? pi / 1 : 0,
          child: SvgPicture.asset(
            GlorifiAssets.caret5Up,
            color:
                change < 0 ? GlorifiColors.red : GlorifiColors.greenTint[700],
          ),
        ),
        Text(
          '${change.abs()}pts',
          style: smallBold16Primary(
            color: GlorifiColors.darkGrey80,
          ),
        ),
      ],
    );
  }
}
