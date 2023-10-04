import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/controller/kyc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';


class ACCVerifySSNScreen extends GetView<KYCController> {
  const ACCVerifySSNScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // TODO: Implement generic error handling @Momshad
        // if (controller.showErrorScreen.value == true) {
        //   return OAOErrorScreen();
        // }
        return ACCContainer(
          children: _content(context),
          info: ACCScreensInfo.ACCVerifySSN,
          onContinue: () async {
            await controller.tokenizationSSNInformation();
            if (controller.pageState == PageState.SUCCESS)
              Get.toNamed(Routes.accEmploymentStatus);
          },
        );
      },
    );
  }

  List<Widget> _content(BuildContext context) {
    return [
      GlorifiTextField(
        textEditingController: controller.ssnController,
        label: TextConstants.ssnText,
        showVisibilityOptions: true,
        keyboardType: TextInputType.number,
        validator: GlorifiTextField.requiredSSN(TextConstants.ssnText),
        inputFormatters: [CardFormatter(sample: "xxx-xx-xxxx", separator: "-")],
      ),
      InkWell(
        onTap: () => Get.toNamed(Routes.accSSNErrorFeedback),
        child: Text(
          TextConstants.iDontHaveIt,
          style: smallRegular16Primary(
            color: GlorifiColors.defaultGradientStartColor,
          ).copyWith(decoration: TextDecoration.underline),
        ),
      ),
      if (controller.accController.isMockEnabled)
        PrimaryDarkButton(
          title: "Identity check flow",
          onTap: () {
            Get.toNamed(Routes.accVerifyIdentity);
          },
        ).marginOnly(top: 20.h),
    ];
  }
}
