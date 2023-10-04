import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_ssn_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/widgets/credit_score_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import '../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

class EnableCreditScoreStep3SSN extends GetView<CreditScoreSsnController> {
  const EnableCreditScoreStep3SSN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.white,
        appBar: GlorifiAppBar(
          title: TextConstants.verifyIdentityText,
          textStyle: bodySemiBold18Primary(
            color: GlorifiColors.midnightBlueColor,
          ),
        ),
        body: SingleChildScrollView(
          child: CreditScoreContainer(
            webTitle: TextConstants.verifyIdentityText,
            title: TextConstants.full_social_securityText,
            subTitle: TextConstants.your_SSNText,
            child: _buildFormContent(_formKey, sizingInfo),
          ),
        ),
      );
    });
  }

  Form _buildFormContent(
      GlobalKey<FormState> _formKey, AdaptiveSizingInfo sizingInfo) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlorifiTextField(
            keyboardType: TextInputType.number,
            textEditingController: controller.ssnController,
            label: TextConstants.ssnText,autofocus: true,
            validator: GlorifiTextField.requiredFieldValidator('your ssn'),
            inputFormatters: [
              CardFormatter(sample: 'xxx-xx-xxxx', separator: '-'),
              DisableEmojiInputFilter.getDisableEmojiInputFilter()
            ],
            onChanged: (_) {
              controller.checkEnableButton();
            },
          ),
          SizedBox(
            height: sizingInfo.isDesktop
                ? 72.h
                : sizingInfo.isTablet
                    ? 64.h
                    : sizingInfo.isWebMobile
                        ? 40.h
                        : 32.h,
          ),
          Obx(
            () => PrimaryDarkButton(
              title: TextConstants.nextText,
              hasRightArrow: true,
              enabled: controller.isButtonEnable.value == true,
              avoidShadow: true,
              height: 64.h,
              iconColor: controller.isButtonEnable.value
                  ? GlorifiColors.lightBlue
                  : GlorifiColors.white,
              onTap: () => {
                if (controller.isButtonEnable.value &&
                    _formKey.currentState!.validate())
                  Get.toNamed(Routes.enableCreditScoreStep4Phone),
              },
            ),
          ),
        ],
      ),
    );
  }
}
