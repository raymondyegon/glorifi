import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glorifi/src/utils/constants.dart';
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

BoxDecoration glorifiBoxDecoration(
    {double radius = 10.0,
    Color bgColor = Colors.white,
    Color borderColor = Colors.white,
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
    Color textColor = GlorifiColors.biscayBlue,
    String font = fontOpenSans,
    bool italic = false}) {
  return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: textColor,
      fontFamily: font,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal);
}

Widget glorifiText(
    {required String text,
    required TextStyle textStyle,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    // overflow: TextOverflow.ellipsis,
    style: textStyle,
  );
}

Widget glorifiTextFieldLabel({
  required TextEditingController textEditingController,
  required String label,
  required String error,
  required bool isCheckValidation,
  ValueChanged<String>? onSubmitted,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      glorifiText(
        text: label,
        textStyle: glorifiTextStyle(
          fontSize: 16.0.sp,
          textColor: GlorifiColors.black,
        ),
      ),
      SizedBox(
        height: 5.0.h,
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        controller: textEditingController,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0.r),
              ),
            ),
            //  prefixIcon: Icon(Icons.search),
            hintStyle: glorifiTextStyle(
                fontSize: 20.0.sp, textColor: Color(0xFF9E9E9E))),
        validator: (value) {
          if ((value == null || value.isEmpty) && isCheckValidation) {
            return error;
          }
          return null;
        },
      )
    ],
  );
}

Widget glorifiTextField({
  required TextEditingController textEditingController,
  required String hint,
  required String label,
  required String error,
  required bool isCheckValidation,
  ValueChanged<String>? onSubmitted,
}) {
  return TextFormField(
    keyboardType: TextInputType.text,
    controller: textEditingController,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0.r),
          ),
        ),
        //  prefixIcon: Icon(Icons.search),
        labelText: label,
        hintText: hint,
        hintStyle:
            glorifiTextStyle(fontSize: 20.0.sp, textColor: Color(0xFF9E9E9E))),
    validator: (value) {
      if ((value == null || value.isEmpty) && isCheckValidation) {
        return error;
      }
      return null;
    },
  );
}

Widget glorifiTextFieldZip({
  required TextEditingController textEditingController,
  required String hint,
  required String label,
  required String error,
  required bool isCheckValidation,
  ValueChanged<String>? onSubmitted,
}) {
  return TextFormField(
    keyboardType: TextInputType.number,
    controller: textEditingController,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    maxLength: 6,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        counter: Offstage(),
        // Only num
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0.r),
          ),
        ),
        //  prefixIcon: Icon(Icons.search),
        labelText: label,
        hintText: hint,
        hintStyle:
            glorifiTextStyle(fontSize: 20.0.sp, textColor: Color(0xFF9E9E9E))),
    validator: (value) {
      if ((value == null || value.isEmpty || value.length != 6) &&
          isCheckValidation) {
        return error;
      }
      return null;
    },
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
        borderColor: GlorifiColors.textColorBlack,
        bgColor: GlorifiColors.textColorBlack,
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
              textColor: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget glorifiButton(
    {required String text,
    Color bgColor = GlorifiColors.biscayBlue,
    Color textColor = GlorifiColors.white,
    required GestureTapCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.all(20.0.r),
      decoration: glorifiBoxDecoration(
        borderColor: bgColor,
        bgColor: bgColor,
        radius: 10.0.r,
      ),
      child: glorifiText(
        text: text,
        textStyle: glorifiTextStyle(
          fontSize: 18.0.r,
          textColor: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
