import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../../../utils/constants.dart';

class CallbackSuccessScreen extends StatelessWidget {
  late FAQCategoriesController fAQCategoriesController;

  CallbackSuccessScreen({Key? key}) : super(key: key) {
    fAQCategoriesController = Get.find<FAQCategoriesController>();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GlorifiColors.superLightGrey,
      appBar: GlorifiAppBar(
        disableLeading: true,
        title: TextConstants.requestCallBack,
      ),
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizingInfo.isDesktop
                      ? 200.w
                      : sizingInfo.isTablet
                          ? 34.5.w
                          : 24.w,
                  vertical: 34),
              child: Column(
                children: [
                  if (!sizingInfo.isNativeMobile)
                    Row(
                      children: [
                        Text(
                          TextConstants.requestCallBack,
                          style: headlineBold26Primary(
                            color: GlorifiColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  SvgPicture.asset(
                    GlorifiAssets.check,
                    height: !sizingInfo.isNativeMobile ? 160.h : 120.h,
                    color: GlorifiColors.black.withOpacity(0.75),
                  ).paddingOnly(top: 57),
                  Text(
                    TextConstants.weWillGetBackToYouAsSoonAsPossible,
                    style: headlineSemiBold21Secondary(
                      color: GlorifiColors.midnightBlueColor,
                    ),
                  ).paddingOnly(top: 68),
                  PrimaryButton(
                    onTap: () {
                      if (fAQCategoriesController.isBottomSheet) {
                        fAQCategoriesController.navigationStack.removeRange(
                            0,
                            fAQCategoriesController.navigationStack
                                .indexOf(ContactSupportCategoryScreen));
                        fAQCategoriesController.update();
                      } else {
                        Get.until((route) => Get.currentRoute
                            .contains('support_contactSupportCategoryScreen'));
                      }
                    },
                    title: TextConstants.backToSupport,
                    hasRightArrow: false,
                    primaryColor: GlorifiColors.primaryDarkButtonColor,
                    textColor: GlorifiColors.superLightGrey,
                    fontSize: 18.sp,
                    height: 64,
                  ).paddingOnly(
                      top: 124,
                      left: sizingInfo.isDesktop ? 180 : 0,
                      right: sizingInfo.isDesktop ? 180 : 0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
