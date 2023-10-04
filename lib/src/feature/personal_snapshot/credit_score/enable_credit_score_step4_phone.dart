import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_phoneno_controller.dart';
import 'package:glorifi/src/controllers/enable_credit_score_main_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/widgets/credit_score_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import '../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../utils/adaptive/adaptive_sizing.dart';
import '../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

class EnableCreditScoreStep4Phone extends GetView<CreditScorePhoneNoController> {
  EnableCreditScoreStep4Phone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.productsBgWhite,
        appBar: GlorifiAppBar(
          title: TextConstants.verifyIdentityText,
          textStyle: bodySemiBold18Primary(
            color: GlorifiColors.midnightBlueColor,
          ),
        ),
        body: SingleChildScrollView(
          child: CreditScoreContainer(
            webTitle: TextConstants.verifyIdentityText,
            title: TextConstants.provide_your_phone_numberText,
            subTitle: TextConstants.your_phone_numberText,
            child: _buildFormContent(context, _formKey, sizingInfo),
          ),
        ),
      );
    });
  }

  Form _buildFormContent(context, GlobalKey<FormState> _formKey, AdaptiveSizingInfo sizingInfo) {
    EnableCreditScoreController enableCreditScoreController =
        Get.find<EnableCreditScoreController>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlorifiTextField(
            label: TextConstants.phone_numberText,
            validator: GlorifiTextField.requiredFieldValidator('your phone number'),
            textEditingController: controller.phoneNoController,
            onChanged: (_) => controller.checkEnableButton(),
            autofocus: true,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              CardFormatter(sample: 'xxx-xxx-xxxx', separator: '-'),
              DisableEmojiInputFilter.getDisableEmojiInputFilter()
            ],
          ),
          SizedBox(height: sizingInfo.isDesktop || sizingInfo.isTablet ? 32.h : 16.h),
          Text(
            TextConstants.use_informationText,
            style: xSmallRegular12Primary(color: GlorifiColors.midnightBlueColor),
          ),
          SizedBox(height: 16.h),
          Text(
            TextConstants.by_clickingText,
            style: xSmallRegular12Primary(color: GlorifiColors.midnightBlueColor),
          ),
          SizedBox(
              height: sizingInfo.isDesktop
                  ? 32.h
                  : sizingInfo.isTablet
                      ? 84.h
                      : 40.h),
          Obx(
            () => PrimaryDarkButton(
                title: "Submit",
                enabled: controller.isButtonEnable.value == true,
                height: 64.h,
                avoidShadow: true,
                iconColor: controller.isButtonEnable.value ? GlorifiColors.lightBlue : GlorifiColors.white,
                isLoading: enableCreditScoreController.isLoading.isTrue,
                onTap: !controller.isButtonEnable.value
                    ? null
                    : () {
                        enableCreditScoreController.submit(context, sizingInfo);
                      }),
          ),
        ],
      ),
    );
  }
}
