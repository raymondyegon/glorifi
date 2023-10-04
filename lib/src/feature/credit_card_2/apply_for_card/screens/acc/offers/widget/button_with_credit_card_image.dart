import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class ButtonWithCreditCardImage extends StatelessWidget {
  ButtonWithCreditCardImage(
      {Key? key, required this.text, required this.image, required this.onTap})
      : super(key: key);

  final String text;
  final String image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Tapped");
        onTap();
      } ,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
            color: GlorifiColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 50.w,
              height: 32.h,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              text,
              style: bodyBold18Primary(color: GlorifiColors.midnightBlue),
            ),
          ],
        ),
      ),
    );
  }
}
