import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';

class ACCCardCancelation extends GetView<ACCController> {
  const ACCCardCancelation({Key? key}) : super(key: key);

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
              ACCScreensInfo.ACCCardCancelation.title,
              style: headlineRegular32Secondary(
                color: GlorifiColors.darkBlueTint[700],
              ),
            ).paddingSymmetric(horizontal: 24.w),
            SizedBox(
              height: 24.h,
            ),
            Text(
              ACCScreensInfo.ACCCardCancelation.subtitle!,
              style: xSmallRegular12Secondary(
                color: GlorifiColors.darkBlueTint[700],
              ),
            ).paddingSymmetric(horizontal: 24.w),
            SizedBox(
              height: 40.h,
            ),
            GlorifiOutlinedButton(
              title: ACCScreensInfo.ACCCardCancelation.ctaTitle,
              textColor: Colors.white,
              height: 60.h,
              onTap: () {
                Get.back();
              },
              primaryColor: GlorifiColors.darkBlue,
              borderColor: GlorifiColors.darkBlue,
            ).paddingSymmetric(horizontal: 24.w),
            SizedBox(
              height: 24.h,
            ),
            GlorifiOutlinedButton(
              title: TextConstants.cancelApplication,
              height: 60.h,
              onTap: () => Get.toNamed(Routes.accConfirmCardCancelation),
              borderColor: GlorifiColors.bloodOrange,
            ).paddingSymmetric(horizontal: 24.w),
            SizedBox(
              height: 90.h,
            ),
          ],
        ),
      ),
    );
  }
}
