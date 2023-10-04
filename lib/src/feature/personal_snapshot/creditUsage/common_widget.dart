import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
AppBar glorifiAppBar({
  required String title,
}) {
  return AppBar(
    title: Text(
      title,
    ),
    elevation: 5.0,
  );
}

BoxDecoration glorifiBoxDecoration({
  double radius = 10.0,
  Color bgColor = GlorifiColors.bgBoxColor,
  Color borderColor = GlorifiColors.bgBoxColor,
  double borderWidth = 0.0,
}) {
  return BoxDecoration(
    color: bgColor,
    border: Border.all(
      color: borderColor,
      width: borderWidth,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(radius),
    ),
  );
}

TextStyle glorifiTextStyle(
    {FontWeight fontWeight = FontWeight.normal,
      required double fontSize,
      Color textColor = GlorifiColors.textColor}) {
  return TextStyle(
      fontWeight: FontWeight.normal, fontSize: fontSize, color: textColor);
}

Widget glorifiText({required String text, required TextStyle textStyle}) {
  return Text(
    text,
    textAlign: TextAlign.start,
    // overflow: TextOverflow.ellipsis,
    style: textStyle,
  );
}

Widget glorifiButton(
    {required String text, required GestureTapCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.all(20.0.r),
      decoration: glorifiBoxDecoration(
        borderColor: GlorifiColors.textColor,
        bgColor: GlorifiColors.textColor,
        radius: 10.0.r,
      ),
      child: glorifiText(
        text: text,
        textStyle: glorifiTextStyle(
          fontSize: 20.0.r,
          textColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget glorifiTextCenter(
    {required String text, required TextStyle textStyle}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    // overflow: TextOverflow.ellipsis,
    style: textStyle,
  );
}