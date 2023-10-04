import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/credit_card_type_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/credit_card_type_card.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class ACCChooseCreditCardTypeScreen extends GetView<ACCController> {
  const ACCChooseCreditCardTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCChooseCreditCardDesignType,
      children: _content(),
    );
  }

  List<Widget> _content() {
    return [
      SizedBox(height: 15.h),
      Text(
        TextConstants.yourCreditCardLimitAndAPR,
        textAlign: TextAlign.start,
        style: smallRegular16Primary(color: GlorifiColors.black),
      ),
      SizedBox(height: 15.h),
      CreditCardTypeCard(
        card: CreditCardType.brassCard,
      ),
      CreditCardTypeCard(
        card: CreditCardType.masterCard,
      )
    ];
  }
}
