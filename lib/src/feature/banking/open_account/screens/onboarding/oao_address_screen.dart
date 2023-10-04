import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_work_state.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/model/address_autocomplete/place_detail_model.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/address_autocomplete/address_autocomplete_widget.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';
class OAOAddressScreen extends StatefulWidget {
  OAOAddressScreen({Key? key}) : super(key: key);

  @override
  State<OAOAddressScreen> createState() => _OAOAddressScreenState();
}

class _OAOAddressScreenState extends State<OAOAddressScreen> {
  OAOController controller = Get.find();
  late bool differentMailingAddress;

  @override
  void initState() {
    differentMailingAddress = controller.application.hasMailingAddress;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return OAOContainer(
      info: OAOScreensInfo.OAOAddressScreen,
      children: _content(),
      onContinue: () async {
        try {
          await controller.verifyAddress(controller.application.address);
          if (differentMailingAddress) {
            await controller.verifyAddress(controller.application.mailingAddress);
          }
          if (controller.application.address.errors.length == 0) {
          await Get.to(
            () => OAOWorkStateScreen(),
          );
        }
        } catch (error) {
          OAOController.showGenericErrorSnackBar(context);
        }
      },
    );
  }

  List<Widget> _content() {
    return <Widget>[
      OAOAddressFormWidget(
        address: controller.application.address,
      ),
      GloriFiCheckBox(
          checked: differentMailingAddress,
          onChanged: (bool? value) {
            if (value == false) {
              controller.application.mailingAddress.clear();
            }

            setState(() {
              differentMailingAddress = value!;
            });
          },
          child: Text(
            "Mailing address, if different from one above.",
            style: TextStyle(color: GlorifiColors.midnightBlue, fontSize: 16),
          ),
          hasBorder: false), 
      if (differentMailingAddress) OAOAddressFormWidget(address: controller.application.mailingAddress),

    ];
  }
}

class OAOAddressFormWidget extends StatefulWidget {
  final PartialAddress address;

  const OAOAddressFormWidget({Key? key, required this.address}) : super(key: key);

  @override
  State<OAOAddressFormWidget> createState() => _OAOAddressFormWidgetState();
}

class _OAOAddressFormWidgetState extends State<OAOAddressFormWidget> {
  TextEditingController _streetController = TextEditingController();
  TextEditingController _suiteController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  late OAOController controller;


  @override
  void initState() {
    controller = Get.find<OAOController>();
    _streetController.text =
        widget.address.line1 ?? '';
    _suiteController.text =
        widget.address.line2 ?? '';
    _zipController.text =
        widget.address.zip ?? '';
    _cityController.text =
        widget.address.city ?? '';
    _stateController.text =
        widget.address.state.value;

    if (_streetController.text == '') {
      widget.address.line1 = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressAutocompleteWidget(
          type: AddressAutocompleteType.glorifiSilverField,
          controller: _streetController,
          onAutocompleteTap: (PlaceDetailModel place) {
            _streetController.text =
                '${place.streetNumber != '' ? '${place.streetNumber} ' : ''}${place.route}';
            _suiteController.text = '';
            _zipController.text = place.zipCode;
            _cityController.text = place.city;
            _stateController.text = place.state;

            widget.address.line1 =
                _streetController.text;
            widget.address.line2 =
                _suiteController.text;
            widget.address.zip =
                _zipController.text;
            widget.address.city =
                _cityController.text;
            widget.address
                .state(_stateController.text);
          },
          hintText: 'Street Address (No P.O. boxes)',
          error: 'your street address',
          onChanged: (value) {
            widget.address.line1 = value;
          },
        ),
        GlorifiTextField(
          label: "Apt/ Suite number (optional)",
          validator: GlorifiTextField.optionalValidator,
          onChanged: (value) {
            widget.address.line2 = value;
          },
          textEditingController: _suiteController,
        ),
        GlorifiTextField(
          label: "City",
          validator: GlorifiTextField.requiredFieldValidator('your city'),
          onChanged: (value) {
            widget.address.city = value;
          },
          textEditingController: _cityController,
        ),
        TwoColumnGloriFiSilverField(
          textField1: Obx(() => StateDropDown(
                value: widget.address.state.value == ""
                  ? null
                    : widget.address.state.value,
              onChanged: (value) {
                  widget.address.state(value);
              },
              )),
          textField2: GlorifiTextField(
            label: "Zip Code",
            keyboardType: TextInputType.number,
            validator:
                GlorifiTextField.requiredFieldValidator('your zip code'),
            onChanged: (value) {
              widget.address.zip = value;
            },
            textEditingController: _zipController,
          ),
        ),
        Obx(() => widget.address.errors.length > 0
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
            : SizedBox.shrink())
      ],
    );
  }

  @override
  void dispose() {
    _streetController.dispose();
    _suiteController.dispose();
    _zipController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }
}
