import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/investment/widgets/submit_button.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CommonMethods {
  Future<void> showHintSheet(String title, String subTitle) {
    return Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: GlorifiColors.bottomSheetBgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    height: 3,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(0, 0, 0, 0.25))),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  title,
                  style: bottomTitleTextStyle,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: bottomSubTitleTextStyle,
                ),
                Spacer(),
                SubmitButton(
                  buttonText: "Got It",
                  onTap: Get.back,
                )
              ],
            ),
          ),
        ),
        elevation: 20.0,
        enableDrag: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        )));
  }
}
