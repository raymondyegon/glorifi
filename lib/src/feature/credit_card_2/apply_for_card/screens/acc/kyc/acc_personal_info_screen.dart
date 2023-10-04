import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/controller/kyc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

class ACCPersonalInformationScreen extends GetView<KYCController> {
  const ACCPersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCPersonalInformation,
      children: _formFields(),
      onContinue: () async {
        await controller.validateBasicInformation();
        if (controller.pageState == PageState.SUCCESS)
          Get.toNamed(Routes.accContactInfo);
      },
    );
  }

  List<Widget> _formFields() {
    return <Widget>[
      GlorifiTextField(
        textEditingController: controller.firstNameController,
        label: "First Name",
        validator: GlorifiTextField.requiredFieldValidator('your first name'),
      ),
      GlorifiTextField(
        textEditingController: controller.middleNameController,
        label: "Middle Name (Optional)",
        validator: GlorifiTextField.optionalValidator,
      ),
      GlorifiTextField(
        textEditingController: controller.lastNameController,
        label: "Last Name",
        validator: GlorifiTextField.requiredFieldValidator('your last name'),
      ),
      GlorifiTextField(
        textEditingController: controller.dobController,
        label: "Date of Birth",
        keyboardType: TextInputType.number,
        inputFormatters: [
          CardFormatter(sample: 'xx/xx/xxxx', separator: '/'),
        ],
        validator: GlorifiTextField.requiredBirthdayDate(),
      ),
    ];
  }
}
