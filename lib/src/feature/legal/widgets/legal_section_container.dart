import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../font_style_global.dart';

class LegalSectionContainer extends StatelessWidget {
  final String title;
  final Color color;
  final double radius;
  final Color titleColor;
  final List<Widget> children;
  final double childrenSpacing;

  const LegalSectionContainer({
    Key? key,
    required this.title,
    this.color = GlorifiColors.white,
    this.radius = GlorifiValues.radius_6,
    this.titleColor = GlorifiColors.midnightBlue,
    this.children = const [],
    this.childrenSpacing = GlorifiValues.margin_2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headlineRegular20Primary(
                color: GlorifiColors.darkBlueTint[900]),
          ),
          SizedBox(height: children.isEmpty ? 0 : 18.h),
          ..._getChildrenWithSpacing(),
        ],
      ),
    );
  }

  _getChildrenWithSpacing() {
    final widgets = [];
    children.forEach(widgets.add);

    return widgets;
  }
}
