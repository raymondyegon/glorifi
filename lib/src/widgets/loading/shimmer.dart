import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeryPlaceHolder extends StatelessWidget {
  final double radius;
  final double? elevation;
  final EdgeInsets? margin;

  const ShimmeryPlaceHolder(
      {Key? key, this.radius = 15, this.elevation, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      // The baseColor and highlightColor creates a LinearGradient which would be painted over the child widget
      baseColor: GlorifiColors.altoGrey,
      highlightColor: Colors.white,
      child: Card(
        elevation: elevation,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: SizedBox.expand(),
      ),
    );
  }
}
