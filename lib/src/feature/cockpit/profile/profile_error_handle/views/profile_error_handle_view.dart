import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/support/support_navigation_helper.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../controllers/profile_error_handle_controller.dart';

class ProfileErrorHandleView extends GetView<ProfileErrorHandleController> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          backgroundColor: GlorifiColors.productsScreenBgWhite,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 47.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome Back.",
                    style: headlineBold31Secondary(
                      color: GlorifiColors.darkBlueColor,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Sorry, we’re currently unable to retrieve your profile details.',
                  style: bodyBold18Primary(
                    color: GlorifiColors.blueMidnightBlue,
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  'Please try again or contact customer support if you need to access your account. ',
                  style: smallRegular16Primary().copyWith(
                    color: GlorifiColors.blueMidnightBlue,
                  ),
                ),
                SizedBox(height: 100.h),
                _tryAgainButton(),
                SizedBox(height: 24.h),
                _callCustomerSupportButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _callCustomerSupportButton() {
    return GlorifiOutlinedButton(
      onTap: () => SupportNavigationHelper.loadBottomSheet(category: 'general'),
      width: Get.width,
      title: 'Contact Support',
      borderColor: GlorifiColors.primaryButtonIconColor,
      textColor: GlorifiColors.darkBlueColor,
    );
  }

  Widget _tryAgainButton() {
    return Obx(
      () {
        return PrimaryButton(
          onTap: () => controller.fetchProfile(),
          isLoading: controller.isLoading.value,
          progressBarColor: GlorifiColors.midnightBlue,
          enabled: !controller.isLoading.value,
          width: Get.width,
          title: "Try Again",
          hasRightArrow: false,
          primaryColor: GlorifiColors.darkBlueColor,
          textColor: GlorifiColors.white,
          fontSize: 18.sp,
        );
      },
    );
  }
}
