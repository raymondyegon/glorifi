import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/savings_checkings_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SavingsCheckingsGraph extends StatelessWidget {
  final data;
  final String? type;

  SavingsCheckingsGraph({required this.data, required this.type});

  List<ChartData> getXAxisDates(cohData) {
    List<ChartData> arr = [];
    cohData.forEach((key, value) {
      var splitData = key.split('-');
      int year = int.parse(splitData[0]);
      int month = int.parse(splitData[1]);
      int day = int.parse(splitData[2]);

      var datetime = DateTime(year, month, day);
      arr.add(ChartData(datetime, double.parse(value)));
    });
    arr.sort((a, b) => a.x.compareTo(b.x));
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Container(
        height: 200,
        child: SfCartesianChart(
          enableAxisAnimation: true,
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
            majorTickLines: MajorTickLines(width: 0),
            axisLine: AxisLine(width: 0),
            labelStyle: TextStyle(
              color: Color(0xFF444E60),
            ),
            majorGridLines: MajorGridLines(
              width: 0,
            ),
            intervalType: DateTimeIntervalType.days,
            dateFormat: DateFormat.MMM('en_US'),
            borderWidth: 0,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelsExtent: 200,
          ),
          primaryYAxis: NumericAxis(
            majorTickLines: MajorTickLines(width: 0),
            axisLine: AxisLine(width: 0),
            maximumLabels: 2,
            majorGridLines: MajorGridLines(
              width: 1,
              dashArray: <double>[2, 4],
              color: Color(0xFFCACFD9),
            ),
            labelStyle: TextStyle(
              color: Color(0xFF444E60),
            ),
            numberFormat: NumberFormat.compactSimpleCurrency(
              decimalDigits: 2,
            ),
          ),
          trackballBehavior: TrackballBehavior(
            lineColor: Color(0xFFCACFD9),
            activationMode: ActivationMode.singleTap,
            enable: true,
            // tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
            // markerSettings: TrackballMarkerSettings(
            //   markerVisibility: TrackballVisibilityMode.visible,
            // ),
          ),
          series: <ChartSeries>[
            SplineSeries<ChartData, DateTime>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              color: Color(0xFF6087D6),
            ),
          ],
        ),
      ),
    );
  }
}
