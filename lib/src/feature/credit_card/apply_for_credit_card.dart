import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../products/widgets/background.dart';
import 'controller/credit_card_controller.dart';

class ApplyForCreditCard extends StatelessWidget {
  const ApplyForCreditCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreditCardController>();

    return Scaffold(
      appBar: GlorifiAppBar(title: TextConstants.creditCard),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Background(
            backgroundImage: GlorifiAssets.applyForCreditCard,
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
                  TextConstants.applyForACreditCard,
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
                  TextConstants.applyForACreditCardThatWorksForYou,
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