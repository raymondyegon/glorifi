import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/fl_chart.dart' as chart;
import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import '../../font_style_global.dart';

import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class BarChart extends StatelessWidget {
  const BarChart({
    Key? key,
    this.selectedIndex,
    required this.data,
    this.isInteractive = false,
  }) : super(key: key);

  final List<BarChartTypeInfo> data;
  final int? selectedIndex;
  final bool isInteractive;

  @override
  Widget build(BuildContext context) {
    final double barWidth = 34.0.w;
    final double groupSpace = 30.w;

    final TextStyle labelTextStyle = captionSemiBold14Primary(
      color: GlorifiColors.midnightBlueColor,
    );

    final TextStyle selectedLabelTextStyle = captionSemiBold14Primary(
      color: GlorifiColors.midnightBlueColor,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final List<BarChartTypeInfo> _data = [];
        final double availableSpace = constraints.maxWidth;
        final int maxBarCount =
            ((groupSpace + availableSpace) / (groupSpace + barWidth)).floor();

        ///if there is more bars then we can fit into available space we show only last few
        if (maxBarCount < data.length) {
          _data.addAll(data.where((element) {
            int index = data.indexOf(element);
            if (index > data.length - maxBarCount - 1) {
              return true;
            } else {
              return false;
            }
          }));
        } else {
          _data.addAll(data);
        }

        return chart.BarChart(
          BarChartData(
              barGroups: [
                ..._data.map((e) {
                  int index = _data.indexOf(e);
                  return BarChartGroupData(x: index, barRods: [
                    BarChartRodData(
                        y: e.measureName.toDouble(),
                        borderRadius: BorderRadius.circular(4.r),
                        width: barWidth,
                        colors: [
                          GlorifiColors.cornflowerBlue,
                          GlorifiColors.gradientLightBlue2,
                        ]),
                  ]);
                }).toList(),
              ],
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              alignment: BarChartAlignment.center,
              groupsSpace: groupSpace,
              barTouchData: BarTouchData(
                enabled: isInteractive,
              ),
              titlesData: FlTitlesData(
                topTitles: SideTitles(),
                rightTitles: SideTitles(),
                leftTitles: SideTitles(),
                bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      if (value.toInt() == selectedIndex) {
                        return selectedLabelTextStyle;
                      }
                      return labelTextStyle;
                    },
                    getTitles: (value) {
                      String label = _data[value.toInt()].domainName;
                      return label;
                    }),
              )),
          swapAnimationDuration: const Duration(milliseconds: 300),
          swapAnimationCurve: Curves.linear,
        );
      },
    );
  }
}

class BarChartTypeInfo {
  final String domainName;
  final double measureName;

  const BarChartTypeInfo(this.domainName, this.measureName);

  factory BarChartTypeInfo.fromJson(Map<dynamic, dynamic> json) {
    return BarChartTypeInfo(
      json["date"],
      json["value"],
    );
  }
}
