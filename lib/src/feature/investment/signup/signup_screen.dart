import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/investment/controller/signup_controller.dart';
import 'package:glorifi/src/feature/investment/widgets/common_method.dart';
import 'package:glorifi/src/feature/investment/widgets/signup_text_form_field.dart';
import 'package:glorifi/src/feature/investment/widgets/submit_button.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();

    return Scaffold(
      backgroundColor: GlorifiColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Start Investing with " +
                      String.fromCharCodes(Runes('\u0024')) +
                      "5",
                  style: textStyleHeading,
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    CommonMethods().showHintSheet(
                      "SignUp",
                      "This is the reason why we ask for creating account",
                    );
                  },
                  child: Text(
                    "Why we need this",
                    style: textStyleSubHeading,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SignUpTextFormField(
                    autoFocus: true,
                    textInputAction: TextInputAction.next,
                    hint: "Email",
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      return controller.emailValidator(value!);
                    },
                    controller: controller.emailController),
                SizedBox(
                  height: 19.h,
                ),
                SignUpTextFormField(
                    textInputAction: TextInputAction.done,
                    hint: "Password",
                    isPassword: true,
                    validator: (value) {
                      return controller.passwordValidator(value!);
                    },
                    controller: controller.passwordController),
                SizedBox(
                  height: 12.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Password Requirements",
                    style: textStyleSubHeading,
                  ),
                ),
                Spacer(
                  flex: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SubmitButton(
                    buttonText: "Create Account",
                    onTap: controller.trySubmit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
