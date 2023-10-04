import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class ChartMarker extends StatelessWidget {
  const ChartMarker({
    Key? key,
    this.size = 24,
    this.color = GlorifiColors.cornflowerBlue,
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 1),
            color: GlorifiColors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          height: size * 0.5,
          width: size * 0.5,
        ),
      ),
    );
  }
}
