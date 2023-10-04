import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

import '../../../../font_style_global.dart';

class ItemProfileNavigation extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String iconPath;

  const ItemProfileNavigation({
    Key? key,
    required this.onTap,
    required this.title,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: GlorifiColors.darkBlue,
          ),
          child: Ripple(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(iconPath,
                      height: 20.h, width: 20.w, color: Colors.white),
                  SizedBox(height: 6.h),
                  Text(title, style: _getTextStyle())
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _getTextStyle() => bodySemiBold18Primary(
        color: GlorifiColors.white,
      );
}
