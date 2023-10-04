import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/charts/line_chart/line_chart_controller.dart';
import 'package:glorifi/src/widgets/charts/widgets/chart_marker.dart';

import '../../../font_style_global.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({
    Key? key,
    this.data = const [],
  })  : _controller =
            Get.put(LineChartController(data), tag: UniqueKey().toString()),
        super(key: key);

  final List<TimeLineChartTypeInfo> data;

  final double markerSize = 24;
  final TextStyle labelTextStyle = captionSemiBold14Primary(
    color: GlorifiColors.cornflowerBlue,
  );

  final LineChartController _controller;
  late bool isEmptyChart;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      GlorifiColors.cornflowerBlue.withOpacity(0.025),
      GlorifiColors.cornflowerBlue.withOpacity(0.25),
    ];

    isEmptyChart = data.isEmpty;
    final double barWidth = 5;
    final double chartPartBottomPadding = isEmptyChart ? 50 : 28;

    return Container(
      height: 65.h,
      //color: Colors.yellow,
      child: LayoutBuilder(builder: (context, constraints) {
        double widgetWidth = constraints.maxWidth;
        _controller.setMarkerPosition(constraints, chartPartBottomPadding);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            _getFirstLabel(context, widgetWidth),
            Align(
              alignment: Alignment.bottomCenter,
              child: _labelWidget(_controller.middleTimestamp),
            ),
            _getLastLabel(context, widgetWidth),
            Padding(
              padding: EdgeInsets.only(bottom: chartPartBottomPadding),
              child: charts.LineChart(
                LineChartData(
                  minX: _controller.firstTimestamp.toDouble(),
                  maxX: _controller.lastTimestamp.toDouble(),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: isEmptyChart ? false : true,
                    border: Border(),
                  ),
                  lineTouchData: LineTouchData(
                    ///user interaction
                    enabled: false,
                  ),
                  titlesData: FlTitlesData(
                    show: false,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      barWidth: barWidth,
                      colors: [
                        GlorifiColors.cornflowerBlue,
                      ],
                      isStrokeCapRound: true,
                      spots: _controller.processedData.map((e) {
                        return FlSpot(
                          e.domainName.millisecondsSinceEpoch.toDouble(),
                          e.measureName.toDouble(),
                        );
                      }).toList(),
                      isCurved: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradientColorStops: [0.1, 1],
                        colors: colors,
                        gradientFrom: Offset(0.5, 1),
                        gradientTo: Offset(0.5, 0),
                      ),
                    ),
                    LineChartBarData(
                      show: false,
                      spots: _controller.processedData.map((e) {
                        return FlSpot(
                          e.domainName.millisecondsSinceEpoch.toDouble(),
                          0,
                        );
                      }).toList(),
                    ),
                  ],
                ),
                swapAnimationDuration: Duration(milliseconds: 300),
                swapAnimationCurve: Curves.linear,
                key: key,
              ),
            ),

            ///custom marker
            isEmptyChart
                ? Positioned(
                    bottom: chartPartBottomPadding - markerSize / 2,
                    right: -5,
                    child: ChartMarker(
                      size: markerSize,
                    ),
                  )
                : Obx(
                    () {
                      return _controller.showMarker.value
                          ? Positioned(
                              bottom: _controller.markerSpot.value!.y.isFinite
                                  ? _controller.markerSpot.value!.y +
                                      chartPartBottomPadding -
                                      markerSize / 2
                                  : 0 + chartPartBottomPadding - markerSize / 2,
                              left: _controller.markerSpot.value!.x -
                                  markerSize / 2,
                              child: ChartMarker(
                                size: markerSize,
                              ),
                            )
                          : Container();
                    },
                  ),
          ],
        );
      }),
    );
  }

  Widget _getFirstLabel(BuildContext context, double widgetWidth) {
    return isEmptyChart
        ? Positioned(
            bottom: 0,
            left: 0,
            child: _labelWidget(_controller.firstTimestamp),
          )
        : Positioned(
            bottom: 0,
            left: widgetWidth * 0.135 -
                _getTextOffset(
                    context,
                    _controller.getLabel(
                        _controller.partialTimestamp13andHalfPercent)),
            child: _labelWidget(_controller.partialTimestamp13andHalfPercent),
          );
  }

  Widget _getLastLabel(BuildContext context, double widgetWidth) {
    return isEmptyChart
        ? Positioned(
            bottom: 0,
            right: 0,
            child: _labelWidget(_controller.lastTimestamp),
          )
        : Positioned(
            bottom: 0,
            left: widgetWidth * 0.865 -
                _getTextOffset(
                    context, _controller.getLabel(_controller.lastTimestamp)),
            child: _labelWidget(_controller.lastTimestamp),
          );
  }

  double _getTextOffset(BuildContext context, String text) {
    return (TextPainter(
                text: TextSpan(text: text, style: labelTextStyle),
                maxLines: 1,
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                textDirection: TextDirection.ltr)
              ..layout())
            .size
            .width /
        2;
  }

  Widget _labelWidget(int timeStamp) {
    return Text(
      _controller.getLabel(timeStamp),
      style: labelTextStyle,
    );
  }
}

class TimeLineChartTypeInfo {
  final DateTime domainName;
  final double measureName;

  TimeLineChartTypeInfo(this.domainName, this.measureName);

  factory TimeLineChartTypeInfo.fromJson(Map<dynamic, dynamic> json) {
    return TimeLineChartTypeInfo(
      json["date"],
      json["value"],
    );
  }
}
