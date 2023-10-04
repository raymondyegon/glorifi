import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CircleIconWidget extends StatelessWidget {
  final String icon;

  const CircleIconWidget({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: GlorifiColors.lightBlueIconBg,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          height: 24,
          color: GlorifiColors.blueIcon,
        ),
      ),
    );
  }
}
