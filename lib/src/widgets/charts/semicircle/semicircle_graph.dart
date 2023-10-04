import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../chart_key.dart';

class SemicircleGraph extends StatelessWidget {
  final double amount1, amount2;
  final String label1, label2;

  final color1 = const Color(0xFFC2D1EF);
  final color2 = const Color(0xFF6490E8);

  SemicircleGraph({
    Key? key,
    required this.amount1,
    required this.label1,
    required this.amount2,
    required this.label2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _makeKeys(),
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.5,
            //ratio places an upper bound on the height of the widgets
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _makeChart(),
                  FractionallySizedBox(
                      widthFactor: 0.54, child: _makeCircleFlare()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _makeChart() {
    final List<ChartData> chartData = [
      ChartData(label1, amount1, color1),
      ChartData(label2, amount2, color2),
    ];

    return SfCircularChart(
      margin: EdgeInsets.zero,
      series: <CircularSeries>[
        // Renders doughnut chart
        DoughnutSeries<ChartData, String>(
          dataSource: chartData,
          pointColorMapper: (ChartData data, _) => data.color,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          innerRadius: '94%',
          explodeGesture: ActivationMode.singleTap,
          animationDuration: 800,
          startAngle: -90,
          endAngle: 90,
        ),
      ],
    );
  }

  Widget _makeKeys() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GraphKey(
          quantity: amount1,
          label: label1,
          color: color1,
        ),
        GraphKey(
          quantity: amount2,
          label: label2,
          color: color2,
        ),
      ],
    );
  }
}

//constructs decoration within graph
Widget _makeCircleFlare() {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF141B3F),
        border: Border.all(color: Color(0xFF1E386B), width: 1.16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 15,
              spreadRadius: 7)
        ]),
  );
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
