import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/investment/widgets/submit_button.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: GlorifiColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 118),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Let’s get started by providing some basic information about yourself",
              style: textStyleHeading,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 49),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SubmitButton(
                  buttonText: "Get Started",
                  onTap: () {
                    Get.toNamed(Routes.stockSelection);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
