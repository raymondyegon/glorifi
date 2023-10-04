import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';

class IndicatorDot extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final double width;
  final double activeWidth;
  final double height;
  final double margin;

  const IndicatorDot({
    Key? key,
    this.isActive = false,
    this.activeColor = GlorifiColors.lightBlue,
    this.inactiveColor = const Color(0xFF86929C),
    this.height = GlorifiValues.valuePagerIndicatorHeight,
    this.width = GlorifiValues.valuePagerIndicatorDotWidth,
    this.activeWidth = GlorifiValues.valuePagerIndicatorActiveDotWidth,
    this.margin = GlorifiValues.margin_2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: margin),
        width: isActive ? activeWidth : width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isActive ? activeColor : inactiveColor,
        ),
      ),
    );
  }
}
