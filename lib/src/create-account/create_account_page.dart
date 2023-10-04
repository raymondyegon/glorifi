import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/create_acc_controller.dart';
import 'package:glorifi/src/glorifi-widgets/glorifi_button.dart';
import '../glorifi-widgets/glorifi_terms_checkbox.dart';
import '../glorifi-widgets/glorifi_textformfield.dart';

class CreateAccountPage extends GetView<CreateAccountController> {
  const CreateAccountPage({Key? key}) : super(key: key);

  final bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: null,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                  Expanded(child: Divider(color: Colors.grey, thickness: 5.0,))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Who are you ?',
                  style: TextStyle(
                    fontFamily: 'univers',
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'We will use this information to verify your identy. Lorem ipsum.',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Colors.black,
                  ),
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GlorifiTextFormField(
                      hintText: "First Name",
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        controller.setFirstName(val);
                        // the setFirstName here is updating the value in controller
                        // to reuse it where it is required in the application.

                      },
                      controller: controller.fNameController.value,
                      cursorColor: Colors.black,
                      enableBorderColor: Colors.grey,
                      focusBorderColor: Colors.grey,
                      outlineBorderColor: Colors.grey,
                      icon: Icons.info_outline_rounded,
                      iconColor: Colors.black87,
                      textColor: Colors.black,
                    ),
                  )),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GlorifiTextFormField(
                      hintText: "Last Name",
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        controller.setLastName(val);
                      },
                      controller: controller.lastNController.value,
                      cursorColor: Colors.black,
                      enableBorderColor: Colors.grey,
                      focusBorderColor: Colors.grey,
                      outlineBorderColor: Colors.grey,
                      icon: Icons.info_outline_rounded,
                      iconColor: Colors.black87,
                      textColor: Colors.black,
                    ),
                  )),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GlorifiTextFormField(
                      hintText: "Birthday",
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        controller.setBirthday(val);
                      },
                      controller: controller.birthdayController.value,
                      cursorColor: Colors.black,
                      enableBorderColor: Colors.grey,
                      focusBorderColor: Colors.grey,
                      textColor: Colors.black,
                      outlineBorderColor: Colors.grey,
                      icon: Icons.info_outline_rounded,
                      iconColor: Colors.black87,
                    ),
                  )),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GlorifiTextFormField(
                      hintText: "Zipcode",
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        controller.setZipcode(val);
                      },
                      maxLength: 6,
                      controller: controller.zipcodeController.value,
                      cursorColor: Colors.black,
                      enableBorderColor: Colors.grey,
                      textColor: Colors.black,
                      focusBorderColor: Colors.grey,
                      outlineBorderColor: Colors.grey,
                      icon: Icons.info_outline_rounded,
                      iconColor: Colors.black87,
                    ),
                  )),
              Row(
                children: [
                  GlorifiCheckbox(
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    onPressed: (bool ischecked) {
                    },

                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'By checking this box, I agree that I have read, understood and consent to GloriFi’s ',
                       style:  TextStyle( color: Colors.black),
                        children: const <TextSpan>[
                          TextSpan(text: 'Terms & Conditions ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          TextSpan(text: 'and ', style: TextStyle( color: Colors.black)),
                          TextSpan(text: 'Privacy Policy.',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: OnboardingButton(
                    btnName: "Next",
                    callback: () {
                      controller.navigateToSecondPage();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
