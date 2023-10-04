import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

Widget SideDivider() {
  return Container(
    width: 54,
    height: 4,
    decoration: BoxDecoration(
        color: GlorifiColors.lightRed,
        borderRadius: BorderRadius.all(Radius.circular(4))),
  );
}
