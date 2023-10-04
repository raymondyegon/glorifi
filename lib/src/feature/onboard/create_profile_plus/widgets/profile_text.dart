import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

Widget profileTitleText(String title) {
  return Text(title,
      style: TextStyle(color: profileTextColor, fontSize: 36.sp, fontFamily: 'univers'));
}

Widget profileBodyText(String text,
    {Color color = profileTextColor, TextAlign align = TextAlign.start}) {
  return Text(text,
      textAlign: align, style: smallRegular16Primary(color: color));
}

Widget editProfileTitleText(String text,
    {Color color = GlorifiColors.black,
    fontSize = 16.0,
    TextAlign align = TextAlign.start}) {
  return Text(
    text,
    textAlign: align,
    style: captionBold14Primary(color: color).copyWith(fontSize: fontSize),
  );
}

Widget editProfileSmallTitleText(String text) {
  return Text(
    text,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  );
}

Widget editProfileBodyText(String text) {
  return Text(
    text,
  );
}

Widget editProfileSmallText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 12),
  );
}

Widget inputTitleText(String text) {
  return Text(
    text,
    style: xSmallRegular12Primary(color: profileWhiteGrey),
  ).paddingOnly(bottom: 4.h);
}

Widget optionalInputSecondaryLabelText(String text) {
  return Text(
    text,
    style: TextStyle(color: profileWhiteGrey, fontSize: 11),
  ).paddingOnly(bottom: 5);
}

Widget emailVerifyTitleText(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(color: profileBackgroundColor, fontSize: 31, fontFamily: 'univers'
    ),
  );
}
