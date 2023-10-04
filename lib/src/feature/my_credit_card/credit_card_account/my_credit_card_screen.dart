import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/my_credit_card/credit_card_account/widgets/credit_card_menu.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'controller/credit_card_account_controller.dart';

class MyCreditCardScreen extends GetView<CreditCardAccountController> {
  const MyCreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreditCardAccountController());
    return Scaffold(
      backgroundColor: GlorifiColors.lightWhite,
      appBar: GlorifiAppBar(
        title: TextConstants.MyCreditCard,
        disableLeading: true,
        elevation: 1,
        trailing: Trailing(
            text: TextConstants.close,
            textStyle: captionSemiBold14Primary(color: GlorifiColors.redError),
            onTap: Get.back),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 41.h),
            InkWell(
                    child: SvgPicture.asset(GlorifiAssets.close,
                        width: 22.w,
                        height: 22.h,
                        color: GlorifiColors.cornflowerBlue),
                    onTap: Get.back)
                .marginOnly(right: 27.w),
            SizedBox(height: 43.h),
            ...List.generate(controller.menuList.length, (index) {
              return CreditCardMenu(data: controller.menuList[index]);
            })
          ],
        ),
      ),
    );
  }
}
