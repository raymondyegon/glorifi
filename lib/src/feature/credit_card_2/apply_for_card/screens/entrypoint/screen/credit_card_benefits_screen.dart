import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/entrypoint/models/credit_card_benefits_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/credit_card_benefit_card.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class CreditCardBenefitsScreen extends StatelessWidget {
  const CreditCardBenefitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: "",
        elevation: 0,
        bgColor: GlorifiColors.superLightGrey,
      ),
      backgroundColor: GlorifiColors.superLightGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Text(
                TextConstants.benefitsHeader,
                style: headlineRegular31Secondary(
                  color: GlorifiColors.darkBlue,
                ),
              ).paddingOnly(top: 30.h, bottom: 40.h),
              CreditCardBenefitCard(
                assetPath: GlorifiAssets.glorifiGoldCreditCardDark,
                cardBenefitsModel:
                    CreditCardBenefitsModel().getBrassCardMockData(),
                onTap: () => Get.toNamed(Routes.brassCardDetails),
              ),
              SizedBox(height: 30.h),
              CreditCardBenefitCard(
                assetPath: GlorifiAssets.glorifiMasterCardBlue,
                cardBenefitsModel:
                    CreditCardBenefitsModel().getGloriFiMastercardMockData(),
                onTap: () => Get.toNamed(Routes.basicCardDetails),
              ),
              SizedBox(height: 135.h),
            ],
          ),
        ),
      ),
    );
  }
}
