import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/enable_credit_score_main_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../../widgets/appbars/glorifi_appbar.dart';
import 'widgets/credit_score_container.dart';

class EnableCreditScoreStep1Name extends GetView<EnableCreditScoreController> {
  const EnableCreditScoreStep1Name({Key? key}) : super(key: key);

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
        body: Obx(
          () => controller.fetchingAddressData.isTrue
              ? Center(child: GlorifiSpinner())
              : SingleChildScrollView(
                  child: CreditScoreContainer(
                    webTitle: TextConstants.verifyIdentityText,
                    title: TextConstants.verifyYourIdentityText,
                    subTitle: TextConstants.wePartneredText,
                    child: _buildFormContent(_formKey, sizingInfo),
                  ),
                ),
        ),
      );
    });
  }

  Widget _buildFormContent(
      GlobalKey<FormState> _formKey, AdaptiveSizingInfo sizingInfo) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlorifiTextField(
            textEditingController: controller.firstNameController,
            label: TextConstants.legalFirstNameText,
            autofocus: true,
            validator:
                GlorifiTextField.requiredFieldValidator('your first name'),
            onChanged: (_) => controller.checkEnableButton(),
          ),
          SizedBox(
            height: sizingInfo.isDesktop
                ? 32.h
                : sizingInfo.isTablet
                    ? 24.h
                    : 16.h,
          ),
          GlorifiTextField(
            textEditingController: controller.lastNameController,
            label: TextConstants.legalLastNameText,
            validator:
                GlorifiTextField.requiredFieldValidator('your last name'),
            onChanged: (_) => controller.checkEnableButton(),
          ),
          SizedBox(
            height: sizingInfo.isDesktop
                ? 32.h
                : sizingInfo.isTablet
                    ? 24.h
                    : 16.h,
          ),
          GlorifiTextField(
            textEditingController: controller.dobController,
            label: "Date of Birth",
            keyboardType: TextInputType.number,
            inputFormatters: [
              CardFormatter(sample: 'xx/xx/xxxx', separator: '/'),
            ],
            validator: GlorifiTextField.requiredBirthdayDate(),
            onChanged: (_) => controller.checkEnableButton(),
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
                hasRightArrow: false,
                enabled: controller.isButtonEnable.value == true,
                height: 64.h,
                avoidShadow: true,
                iconColor: controller.isButtonEnable.value
                    ? GlorifiColors.lightBlue
                    : GlorifiColors.white,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    controller.next();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
