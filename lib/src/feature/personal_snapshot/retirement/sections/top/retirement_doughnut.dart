import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RetirementDoughnut extends StatelessWidget {
  final double value1;
  final double value2;

  RetirementDoughnut({
    Key? key,
    required this.value1,
    required this.value2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Employer-sponsored', value1, const Color(0xFFC2D1EF)),
      ChartData('Individual retirement', value2, const Color(0xFF6490E8)),
    ];

    return ClipRect(
        child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.5,
            child: AspectRatio(
              //places an upper bound on the height of the widgets
              aspectRatio: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SfCircularChart(
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
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.54,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF141B3F),
                          border:
                              Border.all(color: Color(0xFF1E386B), width: 1.16),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.35),
                                blurRadius: 15,
                                spreadRadius: 7)
                          ]),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color = Colors.blue]);
  final String x;
  final double y;
  final Color color;
}
