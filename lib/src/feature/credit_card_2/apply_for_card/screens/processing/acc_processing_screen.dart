import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/processing/acc_processing_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class ACCProcessingScreen extends GetView<ACCProcessingController> {
  ACCProcessingScreen({Key? key}) : super(key: key) {
    controller.initiateProcessing(navigateToNextScreen);
  }

  navigateToNextScreen(String? route) => route == null
      ? null
      : route == "POP"
          ? Get.back()
          : Get.offNamed(route);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.midnightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: GlorifiSpinner(size: 75),
          ).marginOnly(bottom: 48.h),
          Obx(() {
            return Text(
              controller.message,
              style: headlineRegular31Primary(
                color: GlorifiColors.basicLightGrey,
              ),
            ).paddingSymmetric(horizontal: 24.w);
          })
        ],
      ),
    );
  }
}
