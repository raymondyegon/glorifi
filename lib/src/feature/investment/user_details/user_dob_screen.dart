import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/investment/controller/user_name_controller.dart';
import 'package:glorifi/src/feature/investment/widgets/signup_text_form_field.dart';
import 'package:glorifi/src/feature/investment/widgets/submit_button_with_back.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';
import 'package:glorifi/src/routes/app_pages.dart';

class UserDOBScreen extends StatelessWidget {
  const UserDOBScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserNameController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is your date of birth?',
                style: textStyleHeading,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Why we need this",
                style: textStyleSubHeading,
              ),
              Spacer(
                flex: 1,
              ),
              SignUpTextFormField(
                  textInputAction: TextInputAction.next,
                  hint: "MM/DD/YYYY",
                  controller: controller.firstNameController),
              Spacer(
                flex: 10,
              ),
              SubmitButtonWithBack(
                  buttonText: "Next",
                  onTap: () {
                    Get.toNamed(Routes.investmentGender);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
