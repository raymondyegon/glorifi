// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Horizontal bar chart with bar label renderer example and hidden domain axis.
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class HorizontalPatternForwardHatchBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  HorizontalPatternForwardHatchBarChart(this.seriesList,
      {Key? key, this.animate = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(

      seriesList,
      // layoutConfig: charts.LayoutConfig(
      //   // leftMarginSpec: charts.MarginSpec.fixedPixel(0),
      //   topMarginSpec: charts.MarginSpec.fixedPixel(0),
      //   // rightMarginSpec: charts.MarginSpec.fixedPixel(0),
      //   bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      // ),
      animate: true,
      animationDuration: Duration(seconds: 2),
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
      defaultRenderer: charts.BarRendererConfig(
        // By default, bar renderer will draw rounded bars with a constant
        // radius of 100.
        // To not have any rounded corners, use [NoCornerStrategy]
        // To change the radius of the bars, use [ConstCornerStrategy]
        cornerStrategy: const charts.ConstCornerStrategy(4), //ToDo: CashFlow Tracker bar corner
      ),

      /// Assign a custom style for the measure axis.
      ///
      /// The NoneRenderSpec can still draw an axis line with
      /// showAxisLine=true.
      primaryMeasureAxis:
          charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),

      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: charts.OrdinalAxisSpec(
          // Make sure that we draw the domain axis line.
          showAxisLine: true,
          renderSpec: charts.GridlineRendererSpec(
            // Tick and Label styling here.
            labelStyle: charts.TextStyleSpec(
              fontSize: 18, // size in Pts.
              color: charts.ColorUtil.fromDartColor(GlorifiColors.darkBlue),
            ),

            // Change the line colors to match text color.
            lineStyle:
                charts.LineStyleSpec(color: charts.MaterialPalette.transparent),
            // axisLineStyle: charts.LineStyleSpec(
            //   color: charts.ColorUtil.fromDartColor(GlorifiColors.red),
          )
          // But don't draw anything else.
          ),
    );
  }
}
