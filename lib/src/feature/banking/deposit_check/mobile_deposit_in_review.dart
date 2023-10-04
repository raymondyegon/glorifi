import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class MobileDepositInReviewScreen extends StatelessWidget {
  const MobileDepositInReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        appBar: GlorifiAppBar(
          title: 'Mobile Deposit',
          leading: Leading(
            text: "",
            onTap: () => {},
          ),
        ),
        backgroundColor: GlorifiColors.midnightBlue,
        body: Container(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 83.h, bottom: 64.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    GlorifiAssets.errorOval,
                    color: GlorifiColors.white,
                    height: 116.h,
                  ),
                ),
                SizedBox(height: 96.h),
                Text(
                  "Your check cannot be processed",
                  textAlign: TextAlign.left,
                  style: leadRegular24Secondary(color: GlorifiColors.white),
                ),
                SizedBox(height: 31.h),
                Text(
                  """
Unfortunately we cannot process your check at this time.

If you have questions or concerns, please contact customer service at 844-456-7434.""",
                  style: captionRegular14Primary(color: GlorifiColors.white),
                ),
                Spacer(),
                PrimaryButton(
                  title: "Done",
                  width: 342.w,
                  height: 64.h,
                  onTap: () => Get.until(
                      (route) => route.settings.name == Routes.cockpit),
                ),
              ],
            )));
  }
}
