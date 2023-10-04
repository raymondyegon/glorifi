import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/activate_physical_card/controller/cc_activate_physical_card_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/activate_physical_card/widgets/credit_card_last_four_digits_textfield.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class CCActivateCardVerificationScreen
    extends GetView<CCActivatePhysicalCardController> {
  const CCActivateCardVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgColor,
        appBar: GlorifiAppBar(
          title: "",
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Text(
                "Enter the last four digits of your card to activate",
                maxLines: 2,
                style: headlineRegular32Secondary(
                    color: GlorifiColors.midnightBlue),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Text(
                "If you have not received your card in the mail within 7-10 business days, please contact customer support.",
                style: smallRegular16Primary(
                    color: GlorifiColors.defaultGradientStartColor),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            CreditCardLastFourDigitsTextField(controller),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: PrimaryButton(
                  title: "Activate",
                  primaryColor: GlorifiColors.darkBlue,
                  textColor: GlorifiColors.superLightGrey,
                  hasRightArrow: true,
                  iconSpacing: 12,
                  height: 64,
                  fontSize: 18,
                  onTap: () {
                    controller.enableButton.value
                        ? controller.cardActivationSuccess.value
                            ? Get.toNamed(Routes.ccActivatePhysicalCardSuccess)
                            : Get.toNamed(Routes.ccActivatePhysicalCardFailure)
                        : null;
                  }),
            ),
          ],
        ),
      );
    });
  }
}
