import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/top_carousel/coh_v_networth/coh_vs_networth_graph_label.dart';
import 'package:glorifi/src/widgets/charts/chart_data_models.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CohVsNetWorthGraph extends StatelessWidget {
  final networthData;
  final cohData;

  CohVsNetWorthGraph(
      {Key? key, required this.networthData, required this.cohData})
      : super(key: key);

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
    final LinearGradient cohGradient = LinearGradient(
      colors: [
        Color.fromARGB(40, 194, 209, 239),
        Color(0xFFC2D1EF),
      ],
    );

    final LinearGradient networthGradient = LinearGradient(
      colors: [
        Color.fromARGB(40, 100, 144, 231),
        Color(0xFF6490E7),
      ],
    );

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Container(
            height: 220,
            child: SfCartesianChart(
              enableAxisAnimation: true,
              plotAreaBorderWidth: 0,
              primaryXAxis: DateTimeAxis(
                majorTickLines: MajorTickLines(width: 0),
                axisLine: AxisLine(width: 0),
                labelStyle: TextStyle(
                  color: Colors.white,
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
                maximumLabels: 3,
                axisLine: AxisLine(width: 0),
                majorGridLines: MajorGridLines(
                  width: 1,
                  dashArray: <double>[2, 4],
                  color: Color(0xFF444E60),
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                numberFormat: NumberFormat.compactCurrency(
                  decimalDigits: 2,
                  symbol: '',
                ),
              ),
              trackballBehavior: TrackballBehavior(
                lineColor: Color(0xFFCACFD9),
                activationMode: ActivationMode.singleTap,
                enable: true,
                // tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                markerSettings: TrackballMarkerSettings(
                  markerVisibility: TrackballVisibilityMode.visible,
                ),
              ),
              series: <ChartSeries>[
                SplineSeries<GraphData, DateTime>(
                  dataSource: cohData,
                  xValueMapper: (GraphData data, _) => data.x,
                  yValueMapper: (GraphData data, _) => data.y,
                  color: Color.fromARGB(255, 194, 209, 239),
                  animationDelay: 200,
                  animationDuration: 1000,
                ),
                SplineSeries<GraphData, DateTime>(
                  dataSource: networthData,
                  color: Color.fromARGB(255, 100, 144, 231),
                  xValueMapper: (GraphData data, _) => data.x,
                  yValueMapper: (GraphData data, _) => data.y,
                  animationDelay: 1000,
                  animationDuration: 1000,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CohVsNetworthGraphLabel(),
        ],
      ),
    );
  }
}
