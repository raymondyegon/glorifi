import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../../../routes/app_pages.dart';

class BankingStory extends StatelessWidget {
  const BankingStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStory(
      onTap: () => Get.toNamed(
        Routes.openBankAccount,
      ),
      child: Stack(children: [
        Container(
          child: Image.asset(
            "assets/images/banking.png",
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
          alignment: Alignment.topCenter,
          height: 1.sh,
          color: GlorifiColors.midnightBlue,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1.sh,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    GlorifiColors.blueMidnightBlue,
                    GlorifiColors.blueMidnightBlue,
                  ],
                      stops: [
                    0.4,
                    0.7,
                    0.9
                  ])),
            )),
        Container(
            height: 1.sh,
            padding: EdgeInsets.only(bottom: 80.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "GloriFi Banking",
                  style: TextStyle(
                      color: Colors.white, fontSize: 36, fontFamily: 'univers'),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 69.w,
                        child: Divider(
                          color: GlorifiColors.white,
                          height: 1.0,
                          thickness: 1,
                        )),
                    Icon(
                      Icons.star,
                      color: GlorifiColors.darkOrange,
                      size: 30,
                    ),
                    SizedBox(
                        width: 69.w,
                        child: Divider(
                          color: GlorifiColors.white,
                          height: 1.0,
                          thickness: 1,
                        ))
                  ],
                ),
                SizedBox(height: 30.h),
                Text("Open a GloriFi Checking, Savings, and CD\nin minutes.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Learn More",
                      style: smallBold16Primary(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.arrow_forward_sharp,
                      color: GlorifiColors.darkOrange,
                      size: 25.w,
                    )
                  ],
                )
              ],
            )),
      ]),
    );
  }
}
