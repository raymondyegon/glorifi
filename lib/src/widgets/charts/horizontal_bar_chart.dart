import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../font_style_global.dart';

class HorizontalBarChart extends StatelessWidget {
  const HorizontalBarChart({
    Key? key,
    this.colors,
    required this.data,
    this.emptyState = false,
  }) : super(key: key);

  final List<HorizontalBarChartTypeInfo> data;
  final List<Gradient>? colors;
  final bool emptyState;

  @override
  Widget build(BuildContext context) {
    double largestTextWidth = 0;
    double maxValue = 1;
    final double rodHeight = 32.h;
    final TextStyle labelTextStyle = captionBold14Primary(
      color: GlorifiColors.midnightBlueColor,
    );
    final TextStyle valueTextStyle = emptyState
        ? captionRegular14Primary(
            color: GlorifiColors.midnightBlueColor,
          )
        : captionSemiBold14Primary(
            color: GlorifiColors.midnightBlueColor,
          );

    if (emptyState) {
    } else {
      ///Get largest value and largest label size if needed to calculate required free space for text
      data.forEach((element) {
        if (element.measureName > maxValue) {
          maxValue = element.measureName;
        }

        final double width = _getTextSize(
            context,
            _formatValue(
              element.measureName.toDouble(),
            ),
            valueTextStyle);
        if (largestTextWidth < width) {
          largestTextWidth = width;
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.only(right: 28.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final valueLabelSpace = 8.0;
          final reserveToPreventOverflow = 8;
          final double minBarWidth = 4;
          final double availableWidth = constraints.maxWidth -
              largestTextWidth -
              valueLabelSpace -
              reserveToPreventOverflow -
              minBarWidth;
          late Gradient gradient;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: data.map((element) {
              int index = data.indexOf(element);
              final widthRatio = availableWidth / maxValue;
              final barWidth = widthRatio * element.measureName;

              gradient = colors != null && colors!.isNotEmpty
                  ? colors![index]
                  : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        GlorifiColors.gradientLightBlue2,
                        GlorifiColors.cornflowerBlue,
                      ],
                    );

              return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!emptyState)
                        Text(
                          element.domainName,
                          style: labelTextStyle,
                        ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: barWidth,
                            height: rodHeight,
                            constraints: BoxConstraints(
                                minWidth: minBarWidth, minHeight: rodHeight),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              gradient: gradient,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: valueLabelSpace),
                            child: Text(
                              emptyState
                                  ? element.domainName
                                  : _formatValue(
                                      element.measureName.toDouble(),
                                    ),
                              style: valueTextStyle,
                            ),
                          ),
                        ],
                      ),
                      if (index != data.length - 1) SizedBox(height: 24.h),
                    ],
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  String _formatValue(double value) {
    return value == 0
        ? value.toInt().formatSimpleCurrencyZeroInt()
        : value.toInt().formatSimpleCurrencyZeroInt();
  }

  double _getTextSize(BuildContext context, String text, TextStyle textStyle) {
    return (TextPainter(
            text: TextSpan(text: text, style: textStyle),
            maxLines: 1,
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            textDirection: TextDirection.ltr)
          ..layout())
        .size
        .width;
  }
}

class HorizontalBarChartTypeInfo {
  final String domainName;
  final double measureName;

  HorizontalBarChartTypeInfo(this.domainName, this.measureName);
}
