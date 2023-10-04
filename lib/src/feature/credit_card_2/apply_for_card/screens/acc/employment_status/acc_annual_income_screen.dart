import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/employment_status/controller/employment_status_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

class ACCAnnualIncomeScreen extends GetView<EmploymentStatusController> {
  const ACCAnnualIncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCAnnualIncomeScreen,
      children: _content(context),
      disclosureWidget: Text(
        TextConstants.acc_annual_income_footer_text,
        style: smallRegular16Primary(color: GlorifiColors.midnightBlue),
      ).marginOnly(top: 67.h),
      onContinue: () async {
        await controller.validateEmploymentStatus();
        if (controller.pageState == PageState.SUCCESS)
          Get.toNamed(Routes.accAccommodation);
      },
    );
  }

  List<Widget> _content(BuildContext context) {
    return [
      GlorifiTextField(
        textEditingController: controller.annualIncomeController,
        autofocus: true,
        label: "Annual Income",
        keyboardType: TextInputType.number,
        inputFormatters: [
          CurrencyTextInputFormatter(symbol: r"$", decimalDigits: 0),
        ],
      ).marginOnly(bottom: 32.h),
    ];
  }
}
