import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';

import '../../../../banking/controller/my_bank_controller.dart';

class OpenAccountWidget extends StatelessWidget {
  const OpenAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: LinearGradient(colors: [
            GlorifiColors.primaryDarkButtonColor,
            GlorifiColors.primaryDarkButtonColor.withOpacity(0.95),
          ])),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.openBankAccount);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  GlorifiAssets.glorifiLogo,
                  height: 9,
                  width: 27,
                ),
                SizedBox(
                  width: 10.h,
                ),
                Text(
                  TextConstants.gloriFiBanking,
                  style: captionSemiBold14Primary(
                    color: GlorifiColors.white,
                  ).copyWith(height: 1.5),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              TextConstants.weOfferCheckingAccounts,
              style: smallRegular16Primary(color: GlorifiColors.white),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  TextConstants.openAnAccount,
                  style: bodySemiBold18Primary(color: GlorifiColors.white),
                ),
              ],
            )
          ],
        ).paddingSymmetric(horizontal: 16.w, vertical: 24.h),
      ),
    );
  }
}
