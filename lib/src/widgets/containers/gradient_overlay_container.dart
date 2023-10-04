import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';

class GradientOverlayContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final List<double>? stops;
  final List<Color> colors;
  final double borderRadius;

  const GradientOverlayContainer({
    Key? key,
    required this.child,
    this.padding,
    this.colors = const [
      GlorifiColors.defaultGradientStartColor,
      GlorifiColors.defaultGradientEndColor,
    ],
    this.stops,
    this.borderRadius = GlorifiValues.radius_zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
          stops: stops,
          colors: colors,
        ),
      ),
      child: child,
    );
  }
}
