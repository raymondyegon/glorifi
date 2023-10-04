import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_acc_controller.dart';
import 'glorifi_textformfield.dart';
import 'glorifi_button.dart';

class SecondPage extends GetView<CreateAccountController> {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 20),
                    child: GlorifiTextFormField(
                      hintText: "First Name",
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        controller.setFirstName(val);
                      },
                      controller: controller.fNameController.value,
                      cursorColor: Colors.black,
                      enableBorderColor: Colors.grey,
                      focusBorderColor: Colors.grey,
                      outlineBorderColor: Colors.grey,
                      textColor: Colors.black,
                    ),
                  ),
                )),
            Obx(
              () => Center(
                child: Text(
                  controller.birthday.value,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: OnboardingButton(
                btnName: "Go Back",
                callback: Get.back,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
