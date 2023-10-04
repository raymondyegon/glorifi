import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

Widget CCManageSectionHeader({required String text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 64.0, bottom: 24),
    child: Text(
      text,
      style: customGlorifiStyle(
        fontFamily: 'univers',
        weight: FontWeight.w700,
        size: 22.0,
        color: GlorifiColors.black,
      ),
    ),
  );
}
