import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class CCDetailsStickyFooter extends StatelessWidget {
  const CCDetailsStickyFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ACCController>();

    return Container(
      height: 147.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: GlorifiColors.lightWhite,
        boxShadow: [
          BoxShadow(
            color: GlorifiColors.black.withOpacity(.6),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 20.h,
      ),
      child: Column(
        children: [
          Obx(() {
            return PrimaryDarkButton(
              title: TextConstants.applyNow,
              height: 64.h,
              hasRightArrow: true,
              iconColor: GlorifiColors.lightBlue,
              isLoading: controller.pageState == PageState.LOADING,
              onTap: () async {
                await controller.initiateACC();
              },
            ).paddingOnly(bottom: 15);
          }),
          Text(
            TextConstants.thereIsNoImpactToYourCreditScore,
            style: captionRegular14Primary(
              color: GlorifiColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
