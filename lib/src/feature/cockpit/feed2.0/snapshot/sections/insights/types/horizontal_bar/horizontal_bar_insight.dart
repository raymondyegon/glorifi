import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_models.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/base_insight.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/horizontal_bar/horizontal_pattern_flow.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class HorizontalBarInsight extends StatelessWidget {
  final int index;
  final InsightsModel insight;
  final String title;
  final String body;
  final String date;

  const HorizontalBarInsight({
    Key? key,
    required int this.index,
    required InsightsModel this.insight,
    required this.title,
    required this.body,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInsight(
      insight: insight,
      title: title,
      body: body,
      date: date,
      height: 484.h,
      child: Container(
        height: 220.h,
        margin: EdgeInsets.zero,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.transparent, Colors.white.withOpacity(.2)],
              stops: [
                0.0,
                0.45,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: HorizontalPatternForwardHatchBarChart(
            _createRandomData(),
          ),
        ),
      ),
    );
  }

  List<charts.Series<HorizontalSeriesData, String>> _createRandomData() {
    int teaserIndex = insight.teaserBlocks!
        .indexWhere((element) => element.type == 'bar-chart');
    List<HorizontalSeriesData> firstMonth = [];
    List<HorizontalSeriesData> secondMonth = [];
    var firstSeries =
        insight.teaserBlocks![teaserIndex].listOfHorizontalSeries![0];
    var secondSeries =
        insight.teaserBlocks![teaserIndex].listOfHorizontalSeries![1];

    firstMonth.add(
      HorizontalSeriesData(
        insight.teaserBlocks![teaserIndex].categories![0],
        firstSeries[0].value!.toInt(),
      ),
    );
    firstMonth.add(
      HorizontalSeriesData(
        insight.teaserBlocks![teaserIndex].categories![1],
        secondSeries[0].value!.toInt(),
      ),
    );

    secondMonth.add(
      HorizontalSeriesData(
        insight.teaserBlocks![teaserIndex].categories![0],
        firstSeries[1].value!.toInt(),
      ),
    );
    secondMonth.add(
      HorizontalSeriesData(insight.teaserBlocks![teaserIndex].categories![1],
          secondSeries[1].value!.toInt()),
    );

    return [
      charts.Series<HorizontalSeriesData, String>(
        colorFn: (HorizontalSeriesData data, index) =>
            charts.ColorUtil.fromDartColor(GlorifiColors.red),
        id: 'First Month',
        domainFn: (HorizontalSeriesData sales, _) => sales.month,
        measureFn: (HorizontalSeriesData sales, _) => sales.value,
        data: firstMonth,
      ),
      charts.Series<HorizontalSeriesData, String>(
        colorFn: (HorizontalSeriesData data, index) =>
            charts.ColorUtil.fromDartColor(GlorifiColors.gradientRed),
        id: 'Second Month',
        domainFn: (HorizontalSeriesData sales, _) => sales.month,
        measureFn: (HorizontalSeriesData sales, _) => sales.value,
        data: secondMonth,
      )
      // Set the 'Los Angeles Revenue' series to use the secondary measure axis.
      // All series that have this set will use the secondary measure axis.
      // All other series will use the primary measure axis.
    ];
  }
}

class HorizontalSeriesData {
  final String month;
  final int value;

  HorizontalSeriesData(this.month, this.value);
}
