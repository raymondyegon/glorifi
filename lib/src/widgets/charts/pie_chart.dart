import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as PChart;
import 'package:glorifi/src/utils/number_format_util.dart';

enum PieChartLabelType {
  enabled,
  disabled,
  noValues,
}

class PieChart extends StatelessWidget {
  const PieChart({
    Key? key,
    this.colors = const [
      Color(0xff62769D),
      Color(0xffF57367),
      Color(0xffBCC4D5),
      Color(0xff354F81),
      Color(0xffF25041),
      Color(0xff8BBBDA),
      Color(0xff36495A),
      Color(0xff850D0E),
      Color(0xff0E1316),
      Color(0xff1B3568),
    ],
    required this.data,
    this.labelType = PieChartLabelType.enabled,
  }) : super(key: key);

  final List<PieChartTypeInfo> data;
  final List<Color> colors;
  final PieChartLabelType labelType;

  Map<String, double> get _pieChartData {
    final Map<String, double> _pieChartDataMap = {};
    data.forEach((element) {
      _pieChartDataMap.putIfAbsent(
          element.domainName, () => element.measureName.toDouble());
    });
    return _pieChartDataMap;
  }

  @override
  Widget build(BuildContext context) {
    List<Color> _colors = [...colors];

    ///if there is not enough colors for data
    while (_colors.length < data.length) {
      Random random = Random();
      _colors.add(
        Color.fromARGB(
          255,
          random.nextInt(255),
          random.nextInt(255),
          random.nextInt(255),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PChart.PieChart(
              chartLegendSpacing: 0,
              chartRadius: 94,
              dataMap: _pieChartData,
              initialAngleInDegree: 0,
              legendOptions: PChart.LegendOptions(showLegends: false),
              chartValuesOptions:
                  PChart.ChartValuesOptions(showChartValues: false),
              colorList: _colors,
            ),
          ],
        ),
        SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...data.map((e) {
                int index = data.indexOf(e);
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == data.length - 1 ? 0 : 22,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: _colors[index],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${e.domainName}${_getValue(e.measureName)}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 18),
            ],
          ),
        ),
      ],
    );
  }

  String _getValue(double value) {
    switch (labelType) {
      case PieChartLabelType.enabled:
        return ' - ${value.formatSimpleCurrencyZeroDecimal()}';
      case PieChartLabelType.noValues:
        return '';
      case PieChartLabelType.disabled:
        return r' - 0$';
    }
  }
}

class PieChartTypeInfo {
  final String domainName;
  final double measureName;

  PieChartTypeInfo(this.domainName, this.measureName);
}
