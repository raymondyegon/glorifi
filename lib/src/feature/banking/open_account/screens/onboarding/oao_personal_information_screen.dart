import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_contact_info_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';
import 'package:intl/intl.dart';

// Step 2 of 6
// https://app.asana.com/0/1202239119682092/1202240186732667/f
class OAOPersonalInformationScreen extends GetView<OAOController> {
  const OAOPersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
      info: OAOScreensInfo.OAOPersonalInformationScreen,
      children: _content(),
      onContinue: () async {
        await Get.to(
          () => OAOContactInfoScreen(),
        );
      },
    );
  }

  List<Widget> _content() {
    return <Widget>[
      GlorifiTextField(
        initialValue: controller.applicationInProgress.value.firstName,
        label: "First Name",
        validator: GlorifiTextField.requiredFieldValidator('your first name'),
        onChanged: (value) {
          controller.applicationInProgress.value.firstName = value;
        },
      ),
      GlorifiTextField(
        initialValue: controller.applicationInProgress.value.middleName,
        label: "Middle Name (Optional)",
        validator: GlorifiTextField.optionalValidator,
        onChanged: (value) {
          controller.applicationInProgress.value.middleName = value;
        },
      ),
      GlorifiTextField(
        initialValue: controller.applicationInProgress.value.lastName,
        label: "Last Name",
        validator: GlorifiTextField.requiredFieldValidator('your last name'),
        onChanged: (value) {
          controller.applicationInProgress.value.lastName = value;
        },
      ),
      GlorifiTextField(
        initialValue:
            controller.applicationInProgress.value.dob!.toDisplayFormat(),
        label: "Date of Birth",
        keyboardType: TextInputType.number,
        inputFormatters: [
          CardFormatter(sample: 'xx/xx/xxxx', separator: '/'),
        ],
        validator:
            GlorifiTextField.requiredBirthdayDate(),
        onChanged: (value) {
          // Probably inefficient, would be better within onValidate, but MVP!!!
          controller.applicationInProgress.value.dob =
              DateFormat('MM/dd/yy').parse(value);
        },
      ),
    ];
  }
}
