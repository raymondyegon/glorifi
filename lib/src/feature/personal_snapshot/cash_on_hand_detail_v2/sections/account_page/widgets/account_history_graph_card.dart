import 'package:flutter/material.dart';
import 'package:glorifi/src/widgets/charts/chart_data_models.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AccountHistoryGraphCard extends StatelessWidget {
  List<GraphData> data;

  AccountHistoryGraphCard(this.data);

  List<GraphData> getXAxisDates(cohData) {
    List<GraphData> arr = [];
    cohData.forEach((key, value) {
      var splitData = key.split('-');
      int year = int.parse(splitData[0]);
      int month = int.parse(splitData[1]);
      int day = int.parse(splitData[2]);

      var datetime = DateTime(year, month, day);
      arr.add(GraphData(datetime, double.parse(value)));
    });
    arr.sort((a, b) => a.x.compareTo(b.x));
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            Text(
              'Total Spending In The Past 30 Days',
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Univers',
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
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
                    SplineSeries<GraphData, DateTime>(
                      dataSource: data,
                      xValueMapper: (GraphData data, _) => data.x,
                      yValueMapper: (GraphData data, _) => data.y,
                      color: Color(0xFF6087D6),
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
