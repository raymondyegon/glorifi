import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/processing/acc_processing_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/model/address_autocomplete/place_detail_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/address_autocomplete/address_autocomplete_widget.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import 'controller/kyc_controller.dart';

class ACCAddressScreen extends GetView<KYCController> {
  const ACCAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCAddressScreen,
      children: _content(),
      onContinue: () async {
        controller.populateDemographicData();
        final ACCProcessingController _accProcessingController =
            Get.put(ACCProcessingController());
        _accProcessingController.toggleIsFromAddressVerificationScreen(true);
        Get.toNamed(Routes.accProcessing);
      },
    );
  }

  List<Widget> _content() {
    return <Widget>[
      /// Primary Address
      ACCAddressFormWidget(
        controller: controller.primaryAddressController,
        callBack: (PlaceDetailModel place) {
          controller.fillAddressFormField(place);
        },
      ),
      Obx(() {
        return Column(
          children: [
            GloriFiCheckBox(
              checked: controller.getHasDifferentMailingAddress,
              onChanged: (bool? value) {
                controller.toggleDifferentMailingAddress(value);
              },
              child: Text(
                "Mailing address, if different from one above.",
                style: smallRegular16Primary(
                  color: GlorifiColors.darkBlue,
                ),
              ),
              hasBorder: false,
            ),
            if (controller.getHasDifferentMailingAddress) ...[
              /// Mailing Address
              ACCAddressFormWidget(
                controller: controller.mailingAddressController,
                callBack: (PlaceDetailModel place) {
                  controller.fillMailingAddressFormField(place);
                },
              ),
            ]
          ],
        );
      })
    ];
  }
}

class ACCAddressFormWidget extends StatelessWidget {
  const ACCAddressFormWidget({
    Key? key,
    required this.controller,
    required this.callBack,
  }) : super(key: key);

  final AddressController controller;
  final Function(PlaceDetailModel place) callBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressAutocompleteWidget(
          type: AddressAutocompleteType.glorifiSilverField,
          controller: controller.streetController,
          onAutocompleteTap: (PlaceDetailModel place) {
            callBack(place);
            controller.setSelectedState(place.state);
          },
          hintText: 'Street Address (No P.O. boxes)',
          error: 'your street address',
        ),
        GlorifiTextField(
          label: "Apt/ Suite number (optional)",
          validator: GlorifiTextField.optionalValidator,
          textEditingController: controller.aptController,
        ),
        GlorifiTextField(
          label: "City",
          validator: GlorifiTextField.requiredFieldValidator('your city'),
          textEditingController: controller.cityController,
        ),
        TwoColumnGloriFiSilverField(
          textField1: Obx(() => StateDropDown(
                value: controller.selectedState == ""
                    ? null
                    : controller.selectedState,
                onChanged: (value) {
                  controller.setSelectedState(value as String);
                },
              )),
          textField2: GlorifiTextField(
            label: "Zip Code",
            keyboardType: TextInputType.number,
            validator: GlorifiTextField.requiredFieldValidator('your zip code'),
            textEditingController: controller.zipController,
          ),
        ),

        /// DO NOT REMOVE!!
        /// Not sure why this part is needed. So commenting it out.
        /*Obx(() => widget.address.errors.length > 0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (widget.address.errors[index] != "") {
                        return Text(
                          widget.address.errors[index] + "\n",
                          style: TextStyle(color: GlorifiColors.redError),
                        );
                      }
                      return SizedBox.shrink();
                    },
                    itemCount: widget.address.errors.length,
                  )
                : SizedBox.shrink())*/
      ],
    );
  }
}
