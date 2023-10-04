import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class BannerIndicator extends StatelessWidget {
  final bool isActive;

  BannerIndicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 1.0),
      height: 2.5,
      width: isActive ? 36.0 : 18.0,
      decoration: BoxDecoration(
        color: isActive
            ? GlorifiColors.selectedIndicatorColor
            : GlorifiColors.indicatorColor,
      ),
    );
  }
}
