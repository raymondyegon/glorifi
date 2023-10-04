import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_address_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

class OAOContactInfoScreen extends GetView<OAOController> {
  const OAOContactInfoScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OAOContainer(
        info: OAOScreensInfo.OAOContactInfoScreen,
        children: _content(),
        onContinue: () async {
            await Get.to(
                  () => OAOAddressScreen(),
          );
        },
      ),
    );
  }

  List<Widget> _content() {
    final value = controller.applicationInProgress.value;
    String? initialPhone;
    if (value.phoneNumber != null) {
      initialPhone = value.phoneNumber!.replaceAll(RegExp('[^0-9]'), '');
      [3, 7].forEach((element) {
        if (initialPhone!.length > element) {
          initialPhone = initialPhone!.substring(0, element) + ' ' + initialPhone!.substring(element);
        }
      });
    }

    return <Widget>[
      GlorifiTextField(
        initialValue: controller.applicationInProgress.value.phoneNumber,
        label: "Phone Number",
        validator: GlorifiTextField.requiredPhoneNumber(),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          MaskedInputFormatter('000-000-0000'),
        ],
        onChanged: (value) {
          controller.applicationInProgress.value.phoneNumber = value;
        },
      ),
      GlorifiTextField(
        initialValue: controller.applicationInProgress.value.email,
        label: "Email",
        validator: GlorifiTextField.requiredFieldValidator('your email'),
        onChanged: (value) {
          controller.applicationInProgress.value.email = value;
        },
      ),
    ];
  }
}
