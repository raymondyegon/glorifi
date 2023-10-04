import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

AppBar glorifiAppBar({
  required String title,
}) {
  return AppBar(
    title: Text(
      title,
    ),
    centerTitle: false,
    elevation: 5.0,
  );
}

BoxDecoration glorifiBoxDecoration(
    {double radius = 10.0,
    Color bgColor = GlorifiColors.white,
    Color borderColor = GlorifiColors.white,
    double borderWidth = 0.0}) {
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

Widget glorifiTextFieldNumber(
    {required TextEditingController textEditingController,
    required String hint,
    required String label}) {
  return TextField(
    keyboardType: TextInputType.number,
    controller: textEditingController,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0.r),
        ),
      ),
      // labelText: label,
      hintText: hint,
    ),
  );
}

Widget glorifiButtonWithIcon(
    {required String text,
    required Icon icon,
    required GestureTapCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 15.0.w),
      decoration: glorifiBoxDecoration(
        borderColor: GlorifiColors.textColor,
        bgColor: GlorifiColors.textColor,
        radius: 10.0.r,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 5.0.w,
          ),
          glorifiText(
            text: text,
            textStyle: glorifiTextStyle(
              fontSize: 20.0.sp,
              textColor: GlorifiColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
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
          textColor: GlorifiColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
