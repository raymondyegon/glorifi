import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class GloriFiBarChartData {

  GloriFiBarChartData(this.dataLabel, this.value, {this.prefixText = '',
    this.postfixText = '', this.barColor = GlorifiColors.gradientDarkBlue,
    this.focusedBarColor});

  /// dataLabel is the primary label shown below of each bar
  final String dataLabel;
  final double value;

  /// Add any string at beginning or at the end of the value as secondary label
  String prefixText;
  String postfixText;

  Color barColor;

  /// provide specific color to a bar
  Color? focusedBarColor;


}