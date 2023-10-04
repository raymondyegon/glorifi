import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

OutlineInputBorder normalBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: GlorifiColors.textFieldBorder, width: 1),
    borderRadius: BorderRadius.circular(8),
  );
}

OutlineInputBorder activeBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: GlorifiColors.textFieldSelectedBorder,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(8),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(color: GlorifiColors.red, width: 2));
}
