import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_enable_address_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/widgets/credit_score_container.dart';
import 'package:glorifi/src/model/address_autocomplete/place_detail_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/address_autocomplete/address_autocomplete_widget.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../utils/adaptive/adaptive_sizing.dart';
import '../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

class EnableCreditScoreStep2Address
    extends GetView<CreditScoreEnableAddressController> {
  const EnableCreditScoreStep2Address({Key? key}) : super(key: key);

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
            title: TextConstants.provide_your_primary_addressText,
            subTitle: TextConstants.address_will_helpText,
            child: _buildFormContent(_formKey, sizingInfo),
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
          AddressAutocompleteWidget(
              label: TextConstants.street_addressText,
              controller: controller.streetAddressController,
autoFocus: true,
              onAutocompleteTap: (PlaceDetailModel place) {
                controller.fillAddressForm(place);
              },
              error: TextConstants.please_street_addressText),
          SizedBox(
            height: sizingInfo.isDesktop
                ? 32.h
                : sizingInfo.isTablet
                    ? 24.h
                    : 0.h,
          ),
          GlorifiTextField(
            textEditingController: controller.suiteController,
            label: TextConstants.suite_numberText,
            validator: GlorifiTextField.optionalValidator,
            onChanged: (value) => {
              controller.checkEnableButton(),
            },
          ),
          SizedBox(
            height: sizingInfo.isDesktop
                ? 32.h
                : sizingInfo.isTablet
                    ? 24.h
                    : 0.h,
          ),
          GlorifiTextField(
            textEditingController: controller.cityController,
            label: TextConstants.cityText,
            validator: GlorifiTextField.requiredFieldValidator('your city'),
            onChanged: (value) => {
              controller.checkEnableButton(),
            },
          ),
          SizedBox(
            height: sizingInfo.isDesktop
                ? 32.h
                : sizingInfo.isTablet
                    ? 24.h
                    : 0.h,
          ),
          SizedBox(
            height: sizingInfo.isDesktop
                ? 32.h
                : sizingInfo.isTablet
                    ? 24.h
                    : 0.h,
          ),
          TwoColumnGloriFiSilverField(
            textField1: Obx(
              () => StateDropDown(
                value: controller.selectedState.value == ''
                    ? null
                    : controller.selectedState.value,
                onChanged: (value) {
                  controller.selectedState(value);
                },
              ),
            ),
            textField2: GlorifiTextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              textEditingController: controller.zipCodeController,
              label: TextConstants.zip_codeText,
              validator:
                  GlorifiTextField.requiredFieldValidator('your zip code'),
              onChanged: (value) => {
                controller.checkEnableButton(),
              },
            ),
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
              hasRightArrow: true,
              title: TextConstants.nextText,
              enabled: controller.isButtonEnable.value == true,
              height: 64.h,
              avoidShadow: true,
              iconColor: controller.isButtonEnable.value ? GlorifiColors.lightBlue : GlorifiColors.white,
              onTap: () => {
                if (controller.isButtonEnable.value &&
                    _formKey.currentState!.validate())
                  Get.toNamed(Routes.enableCreditScoreStep3SSN),
              },
            ),
          ),
        ],
      ),
    );
  }
}
