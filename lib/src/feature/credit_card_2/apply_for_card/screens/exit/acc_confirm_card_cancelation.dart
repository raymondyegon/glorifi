import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/cockpit_screen.dart';
import 'package:glorifi/src/feature/cockpit/controllers/cockpit_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';

class ACCConfirmCardCancellation extends GetView<ACCController> {
  const ACCConfirmCardCancellation({Key? key}) : super(key: key);

  CockpitController get _cockpitController => Get.find<CockpitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.white,
      appBar: AppBar(
        backgroundColor: GlorifiColors.white,
        title: Text(
          "Apply",
          style: bodyRegular18Secondary(
            color: GlorifiColors.darkBlueTint[700],
          ),
        ),
        leading: InkWell(
          onTap: Get.back,
          child: Icon(
            Icons.arrow_back_ios,
            color: GlorifiColors.denimBlue,
            size: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/progress_bar_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              ACCScreensInfo.ACCConfirmCardCancelation.title,
              style: headlineRegular32Secondary(
                color: GlorifiColors.darkBlueTint[700],
              ),
            ).paddingSymmetric(horizontal: 24.w),
            SizedBox(
              height: 24.h,
            ),
            Text(
              ACCScreensInfo.ACCConfirmCardCancelation.subtitle!,
              style: xSmallRegular12Secondary(
                color: GlorifiColors.darkBlueTint[700],
              ),
            ).paddingSymmetric(horizontal: 24.w),
            SizedBox(
              height: 40.h,
            ),
            leaveApplicationButton().paddingSymmetric(horizontal: 24.w),
            SizedBox(
              height: 24.h,
            ),
            GlorifiOutlinedButton(
              title: TextConstants.wantTheCard,
              height: 60.h,
              borderColor: GlorifiColors.bloodOrange,
              onTap: () {
                Get.back();
                Get.back();
              },
            ).paddingSymmetric(horizontal: 24.w),
            SizedBox(
              height: 90.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget leaveApplicationButton() {
    return Container(
      width: 1.sw,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // <-- Radius
          ),
          primary: Colors.white,
          backgroundColor: GlorifiColors.darkBlueTint[700],
          padding: EdgeInsets.all(24),
        ),
        onPressed: controller.isLoading.value
            ? null
            : () async {
                try {
                  controller.isLoading.value = false;

                  _cockpitController.currentTab.value = CockpitTab.accounts;
                  _cockpitController.isTabSelected(CockpitTab.accounts);
                  Get.offNamed(
                    Routes.cockpit,
                  );
                } finally {
                  controller.isLoading.value = false;
                }
              },
        label: controller.isLoading.value
            ? SizedBox(
                height: 24.0,
                width: 24.0,
                child: CircularProgressIndicator(
                  color: Colors.white54,
                ),
              ).paddingOnly(left: 10)
            : Icon(Icons.arrow_forward, size: 18.0, color: GlorifiColors.lightBlue),
        icon: Text(
          ACCScreensInfo.ACCConfirmCardCancelation.ctaTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ), // <-- Text
      ),
    );
  }
}
