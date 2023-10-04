import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/acc_address_info_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import 'controller/kyc_controller.dart';

class ACCContactInfoScreen extends GetView<KYCController> {
  const ACCContactInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ACCContainer(
        info: ACCScreensInfo.ACCContactInfoScreen,
        children: _formField(),
        onContinue: () async {
          await controller.validateContactInformation();
          if (controller.pageState == PageState.SUCCESS)
            Get.toNamed(Routes.accAddress);
        },
        disclosureWidget: _buildDisclosureWidget(),
      ),
    );
  }

  List<Widget> _formField() {
    return <Widget>[
      GlorifiTextField(
        textEditingController: controller.phoneNumberController,
        label: "Phone Number",
        onChanged: (val){
          controller.phoneNumberController.selection = TextSelection.fromPosition(TextPosition(offset: controller.phoneNumberController.text.length));
        },
        validator: GlorifiTextField.requiredPhoneNumber(),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          MaskedInputFormatter('000 000 0000'),
        ],
      ),
      GlorifiTextField(
        textEditingController: controller.emailController,
        label: "Email",
        validator: GlorifiTextField.requiredEmailValidator(),
      ),
    ];
  }

  Widget _buildDisclosureWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: RichText(
        text: TextSpan(
          text: TextConstants.byProvidingMobilePhoneNumber,
          style: xSmallSemiBold12Primary(
            color: GlorifiColors.dateDarkGrey,
          ),
          children: [
            TextSpan(
              text: TextConstants.emailsAndAutomatedTextMessages,
              style: xSmallBold12Primary(
                color: GlorifiColors.blueMidnightBlue,
              ),
            ),
            TextSpan(text: TextConstants.forMoreDetails),
          ],
        ),
      ),
    );
  }
}
