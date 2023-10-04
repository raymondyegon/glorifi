import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../products/widgets/background.dart';
import 'controller/my_bank_controller.dart';

class SignUpInMinutes extends StatelessWidget {
  const SignUpInMinutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyBankController>();

    return Scaffold(
      appBar: GlorifiAppBar(title: TextConstants.banking),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Background(
            backgroundImage: GlorifiAssets.horse2,
            gradientColors: [
              GlorifiColors.ebonyBlue,
              GlorifiColors.whiteBlue.withOpacity(0),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstants.signUpInMinutes,
                  style: headlineRegular40Secondary(
                    color: GlorifiColors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  TextConstants.itsEasyAndSecure,
                  style: headlineRegular31Secondary(
                    color: GlorifiColors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  TextConstants.openingAnAccountIsEasy,
                  style: captionRegular14Secondary().copyWith(
                    color: GlorifiColors.white,
                    height: 2,
                  ),
                ),
                SizedBox(height: 32),
                PrimaryButton(
                  title: TextConstants.continueButton,
                  hasRightArrow: true,
                  width: Get.width,
                  onTap: controller.navigateToBlend,
                ),
                SizedBox(height: 32),
              ],
            ),
          )
        ],
      ),
    );
  }
}
