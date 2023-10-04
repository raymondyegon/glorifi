import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/controller/Identity_check_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class VerifyIdentityScreen extends GetView<IdentityCheckController> {
  VerifyIdentityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      children: _content(),
      info: ACCScreensInfo.verifyIdentityScreen,
      onContinue: () {
        Get.toNamed(Routes.accEmploymentStatus);
      },
    );
  }

  List<Widget> _content() {
    return [
      Container(
        width: 342.w,
        height: 296.h,
        child: Column(
          children: [
            Stack(
              children: [
                SvgPicture.asset(GlorifiAssets.grayAngleBackground),
                Center(
                  child: Container(
                    width: 156.w,
                    height: 219.h,
                    margin: EdgeInsets.only(top: 64.h),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: GlorifiColors.darkBlue, width: 2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(top: 45.h),
                        color: GlorifiColors.white,
                        child: Image.asset(
                          GlorifiAssets.photoPlaceholder,
                          width: 148.w,
                          height: 168.h,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 80.h,
      )
    ];
  }
}
