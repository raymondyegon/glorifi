import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_models.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/base_insight.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'slice.dart';

class PieChartInsight extends StatelessWidget {
  final int index;
  final InsightsModel insight;
  final String title;
  final String body;
  final String date;

  const PieChartInsight(
      {Key? key,
      required int this.index,
      required InsightsModel this.insight,
      required this.title,
      required this.body,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //           Color(0xFFA61011),
    //           Color(0xFFF25041)
    final List<ChartData> chartData = [];
    // final List<ChartData> chartData = [
    //   ChartData('David', 25, Color(0xFF1F3B73)),
    //   ChartData('Steve', 38, Color(0xFFA61011)),
    //   ChartData('Jack', 34, Color(0xFFF25041)),
    //   ChartData('Others', 52, Color(0xFFF25041))
    // ];
    int teaserIndex = insight.teaserBlocks!
        .indexWhere((element) => element.type == 'pie-chart');

    List<Slice>? slices = insight.teaserBlocks![teaserIndex].slices;
    slices!.forEach((element) {
      var chart = ChartData(
          element.category, element.value, Color(0xFF1F3B73), element.category);
      chartData.add(chart);
    });

    // pie-chart

    List<Color> colors = <Color>[
      const Color(0xFF1F3B73),
      const Color(0xFF6C7EA2),
      const Color(0xFF6C7EA2).withOpacity(.4),
    ];

    List<double> stops = <double>[0.2, 0.5, 1];

    return BaseInsight(
      insight: insight,
      title: title,
      body: body,
      date: date,
      height: 500,
      child: SizedBox(
          height: 300,
          child: SfCircularChart(
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                widget: Text(
                  '${insight.teaserBlocks![teaserIndex].centerText}',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Color(0xFF1F3B73),
                    fontSize: 25,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            onCreateShader: (ChartShaderDetails chartShaderDetails) {
              return ui.Gradient.sweep(
                chartShaderDetails.outerRect.center,
                colors,
                stops,
                TileMode.clamp,
                _degreeToRadian(0),
                _degreeToRadian(360),
                _resolveTransform(
                    chartShaderDetails.outerRect, TextDirection.ltr),
              );
            },
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  connectorLineSettings: ConnectorLineSettings(
                    color: Colors.black.withOpacity(0.5),
                    width: 1.5,
                    type: ConnectorType.curve,
                  ),
                ),
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelMapper: (ChartData data, _) => data.text,
                // Radius of doughnut
                radius: '70%',
                innerRadius: '60%',
                // explode: true,
                // explodeIndex: 1,
                animationDuration: 3100,
              )
            ],
          )
          // child: ShaderMask(
          //     shaderCallback: (Rect bounds) {
          //       return LinearGradient(
          //         begin: Alignment.centerLeft,
          //         end: Alignment.centerRight,
          //         colors: [
          //           Color(0xFF1F3B73),
          //           Color(0xFFA61011),
          //           Color(0xFFF25041)
          //         ],
          //         stops: [
          //           0.0,
          //           0.2,
          //           0.7,
          //         ],
          //       ).createShader(bounds);
          //     },
          //     blendMode: BlendMode.srcOut,
          //     child: DonutPieChart(createPieData(),animate: true)),
          ),
    );
  }

  // Rotate the sweep gradient according to the start angle
  Float64List _resolveTransform(Rect bounds, TextDirection textDirection) {
    final GradientTransform transform = GradientRotation(_degreeToRadian(-90));
    return transform.transform(bounds, textDirection: textDirection)!.storage;
  }

  // Convert degree to radian
  double _degreeToRadian(int deg) => deg * (3.141592653589793 / 180);
}

class ChartData {
  ChartData(this.x, this.y, this.color, this.text);

  final String x;
  final double y;
  final String text;
  final Color color;
}
