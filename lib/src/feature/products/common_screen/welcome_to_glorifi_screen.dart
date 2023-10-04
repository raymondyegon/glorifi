import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/text_constants.dart';

import '../../../font_style_global.dart';
import '../../../routes/app_pages.dart';
import '../widgets/background.dart';

class WelcomeToGlorifi extends StatelessWidget {
  const WelcomeToGlorifi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragStart: (details) => onSwipeNavigateTo(),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Background(
              backgroundImage: GlorifiAssets.beach,
              gradientColors: [
                GlorifiColors.ebonyBlue.withOpacity(.59),
                GlorifiColors.whiteBlue.withOpacity(0),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    // Text(
                    //   "Welcome to GloriFi Banking",
                    //   style: headlineRegular37Secondary(
                    //     color: GlorifiColors.biscayBlue,
                    //   ),
                    // ),
                    Spacer(),
                    // Center(
                    //   child: Icon(
                    //     Icons.keyboard_arrow_up,
                    //     size: 50,
                    //     color: GlorifiColors.lightBlue,
                    //   ),
                    // ),
                    SizedBox(height: 8),
                    Text(
                      TextConstants.glorifiIsAFinancialTechnologyCompany,
                      style: xSmallSemiBold12Primary(
                        color: GlorifiColors.spanishGray,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSwipeNavigateTo() {
    if (Get.arguments["screen"] == "Banking") {
      Map<String, dynamic> _args = Get.arguments;
      _args.remove("screen");
      Get.offNamed(Routes.openBankAccount, arguments: _args);
    } else if (Get.arguments["screen"] == "Credit Card") {
      Get.offNamed(Routes.applyForCreditCardScreen);
    }
  }
}
