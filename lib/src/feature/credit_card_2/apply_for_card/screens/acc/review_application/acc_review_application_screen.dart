import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/member_application_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/review_application/acc_review_application_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_terms_and_condition_widget.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/credit_card.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/personal_details_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class ACCReviewApplicationScreen
    extends GetView<ACCReviewApplicationController> {
  const ACCReviewApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCReviewApplication,
      disclosureWidget: Text(
        TextConstants.allInformationReviewApplication,
        style: xSmallSemiBold12Primary(
          color: GlorifiColors.dateDarkGrey,
        ),
      ).paddingOnly(top: 32.h, bottom: 42.h),
      children: contents(),
      onContinue: null,
    );
  }

  List<Widget> contents() {
    return [
      CreditCard(
        name: "Everyday Card",
        description: "APR 15.99%-20.99%",
      ),
      SizedBox(height: 23.h),
      PersonalDetailsWidget(
        accMemberApplicationModel: Get.find<ACCMemberApplicationModel>(),
      ),
      ACCTermsAndCondition(),
      Obx(
        () => PrimaryDarkButton(
          title: "Submit Application",
          enabled: controller.isElectronicConsentAgreement.value,
          onTap: () {
            Get.toNamed(Routes.accProcessing);
          },
        ),
      ),
    ];
  }
}
