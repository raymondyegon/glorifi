import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';

OutlineInputBorder normalBorder() {
  return OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(GlorifiValues.smallRadius)),
      borderSide: BorderSide(color: profileGrey, width: 1.5));
}

OutlineInputBorder activeBorder() {
  return OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(GlorifiValues.smallRadius)),
      borderSide: BorderSide(color: profileIconColor, width: 1.5));
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(GlorifiValues.smallRadius)),
      borderSide: BorderSide(color: profileRed, width: 1.5));
}
