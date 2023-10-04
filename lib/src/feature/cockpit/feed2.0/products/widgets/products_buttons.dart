import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/buttons/custom_async_button.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

Widget AccessButton(VoidCallback onTap) {
  
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: CustomAsyncButton(
      onTap: onTap,
      loadingWidget: _loadingButton(),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            "Gain Early Access",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: "OpenSans",
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _loadingButton() {
  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: GlorifiColors.darkBlue,
        ),
      ));
}
  


Widget LearnMoreButton() {
  return Ripple(
    onTap: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Learn More',
          style: captionBold14Primary(color: GlorifiColors.white),
        ),
        Icon(
          Icons.arrow_right_alt,
          color: GlorifiColors.lightBlue,
        ).paddingOnly(left: 11)
      ],
    ).paddingAll(15),
  ).paddingOnly(top: 12, left: 36, right: 36, bottom: 100);
}
