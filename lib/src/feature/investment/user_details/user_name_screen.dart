import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/investment/controller/user_name_controller.dart';
import 'package:glorifi/src/feature/investment/widgets/signup_text_form_field.dart';
import 'package:glorifi/src/feature/investment/widgets/submit_button.dart';

import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';

class UserNameScreen extends GetView<UserNameController> {
  const UserNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.nameFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'What is your full, legal name?',
                  style: textStyleHeading,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Why we need this",
                  style: textStyleSubHeading,
                ),
                SizedBox(
                  height: 15,
                ),
                Spacer(
                  flex: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                SignUpTextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return controller.firstNameValidator(value!);
                    },
                    hint: "First Name",
                    controller: controller.firstNameController),
                SizedBox(
                  height: 10,
                ),
                SignUpTextFormField(
                    textInputAction: TextInputAction.next,
                    hint: "Middle Name (optional)",
                    controller: controller.middleNameController),
                SizedBox(
                  height: 10,
                ),
                SignUpTextFormField(
                    validator: (value) {
                      return controller.lastNameValidator(value!);
                    },
                    textInputAction: TextInputAction.done,
                    hint: "Last Name",
                    controller: controller.lastNameController),
                Spacer(
                  flex: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SubmitButton(
                      buttonText: "Next",
                      onTap: () {
                        controller.trySubmit();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
