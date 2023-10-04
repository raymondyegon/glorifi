import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_models.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/base_insight.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

class PinChartInsight extends StatelessWidget {
  final int index;
  final InsightsModel insight;
  final String title;
  final String body;
  final String date;

  const PinChartInsight({
    Key? key,
    required int this.index,
    required InsightsModel this.insight,
    required this.title,
    required this.body,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int teaserIndex = insight.teaserBlocks!
        .indexWhere((element) => element.type == 'pin-chart');
    double totalValue = 0;

    final List<PinChartData> chartData = [];

    for (int i = 0;
        i < insight.teaserBlocks![teaserIndex].series!.length;
        i++) {
      chartData.add(PinChartData(
          insight.teaserBlocks![teaserIndex].series![i].label!,
          insight.teaserBlocks![teaserIndex].categories![i],
          insight.teaserBlocks![teaserIndex].series![i].value!));
    }

    insight.teaserBlocks![teaserIndex].series!.forEach((element) {
      totalValue += element.value!;
    });

    final List<Color> color = <Color>[];
    color.add(Color(0xFFD11415));
    color.add(Color(0xFFD11415).withOpacity(.7));
    color.add(Color(0xFFD11415).withOpacity(.5));

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    return BaseInsight(
      insight: insight,
      title: title,
      body: body,
      date: date,
      height: 525,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: SfCartesianChart(
              borderColor: Colors.transparent,
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                //Customize the axis line.
                axisLine: AxisLine(color: Colors.cyan, width: 0),

                //Major grid line customization.
                majorGridLines: MajorGridLines(color: Colors.cyan, width: 0),

                //Minor grid line customization.
                minorGridLines: MinorGridLines(color: Colors.black12, width: 0),

                //Major tick line customization.
                majorTickLines: MajorTickLines(color: Colors.cyan, size: 0),

                //Minor tick line customization.
                minorTickLines: MinorTickLines(color: Colors.black12, size: 0),
              ),
              primaryYAxis: NumericAxis(
                isVisible: false,
                // Customize the axis line.
                axisLine: AxisLine(color: Colors.cyan, width: 0),

                //Grid line customization.
                majorGridLines: MajorGridLines(color: Colors.cyan, width: 0),

                //Minor grid line customization.
                minorGridLines: MinorGridLines(color: Colors.black12, width: 0),

                //Major tick line customization.
                majorTickLines: MajorTickLines(color: Colors.cyan, size: 0),

                //Minor tick line customization.
                minorTickLines: MinorTickLines(color: Colors.black12, size: 0),
                numberFormat: NumberFormat.compact(),
                // majorGridLines: const MajorGridLines(width: 0),
                name: 'yAxis1',
              ),
              series: <ChartSeries<PinChartData, String>>[
                ColumnSeries<PinChartData, String>(
                  animationDuration: 3000,
                  dataSource: chartData,
                  onCreateShader: (ShaderDetails details) {
                    return ui.Gradient.linear(
                      details.rect.bottomCenter,
                      details.rect.topCenter,
                      color,
                      stops,
                    );
                  },
                  xValueMapper: (PinChartData data, _) => data.x,
                  yValueMapper: (PinChartData data, _) => data.y,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              '\$${totalValue}',
              textScaleFactor: 1,
              style: TextStyle(
                color: Color(0xFF1F3B73),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PinChartData {
  final String category;
  final String x;
  final double y;

  PinChartData(this.category, this.x, this.y);
}
