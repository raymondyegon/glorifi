import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/double_utils.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'model/glorifi_bar_chart_model.dart';

class GloriFiBarChart extends StatelessWidget {
  final List<GloriFiBarChartData> data;
  final List<Widget> gloriFiBarChartItemWidget = [];
  final double barGap;
  final double barRadius;
  final double barWidth;

  GloriFiBarChart(
      {Key? key,
      required this.data, this.barGap = 20, this.barRadius = 8,
        this.barWidth = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      /// Taking space (60 unit) from the parent height for display labels
      double labelHeight = (constraints.maxHeight > 60 ? 60 : 0).h;

      gloriFiBarChartItemWidget.clear();

      /// Defining dynamic height
      /// Considering max valued item as the 100% . Calculating each bar height relative to [maxBarChartData]
      GloriFiBarChartData maxBarChartData =
          data.reduce((a, b) => a.value > b.value ? a : b);

      /// Generating bars
      for (GloriFiBarChartData gloriFiBarChartData in data) {

        /// Current bar height ratio relative to max valued bar height
        final heightRatio = maxBarChartData.value / gloriFiBarChartData.value;
        final height = ((constraints.maxHeight - labelHeight) / heightRatio).h;


          gloriFiBarChartItemWidget.add(Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            getBar(height,gloriFiBarChartData.focusedBarColor??gloriFiBarChartData.barColor),
            SizedBox(
              height: 12,
            ),
            getPrimaryLabel(gloriFiBarChartData.dataLabel),
            SizedBox(
              height: 4,
            ),
            getSecondaryLabel(gloriFiBarChartData)
          ],
        ));

        /// adding horizontal gap to right of the bar
        gloriFiBarChartItemWidget.add(SizedBox(width: barGap));
      }


      return Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            children: gloriFiBarChartItemWidget,
          ),
        ),
      );
    });
  }

  String getFormattedSecondaryLabel(GloriFiBarChartData gloriFiBarChartData) {
    return '${gloriFiBarChartData.prefixText}${gloriFiBarChartData.value
        .formatNumberInEn_US()}${gloriFiBarChartData.postfixText}';
  }

  TextStyle customTinyRegular10PrimaryTextStyle() {
    return tinyRegular10Primary(color: GlorifiColors.creditBgGrey)
        .copyWith(fontWeight: FontWeight.w600);
  }

  Container getBar(double height, Color color) {
    return Container(
      height: height,
      width: barWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(barRadius),
          color: color),
    );
  }

  Text getPrimaryLabel(String primaryLabel) {
    return Text(
      primaryLabel,
      style: captionSemiBold14Primary(),
      textAlign: TextAlign.center,
    );
  }

  Text getSecondaryLabel(GloriFiBarChartData gloriFiBarChartData) {
    return Text(getFormattedSecondaryLabel(gloriFiBarChartData),
        style: customTinyRegular10PrimaryTextStyle(),
        textAlign: TextAlign.center);
  }
}
