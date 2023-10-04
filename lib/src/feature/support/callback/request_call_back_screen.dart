import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/callback_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/feature/support/support_widgets/faq_textfield_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/shared/app_button.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';
import 'package:intl/intl.dart';

import '../../../controllers/support/faq_categories_controller.dart';
import '../../onboard/create_profile_plus/widgets/input_suffix_icon.dart';

class RequestCallbackScreen extends StatelessWidget {
  late final category;
  late FAQCategoriesController faqCategoriesController;
  late CallBackController controller;

  RequestCallbackScreen({Key? key}) : super(key: key) {
    faqCategoriesController = Get.find<FAQCategoriesController>();
    controller = Get.isRegistered<CallBackController>()
        ? Get.find<CallBackController>()
        : Get.put(CallBackController());

    category = Get.arguments == null
        ? faqCategoriesController.selectedSupportCategoryTitle
        : Get.arguments['category'];
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: GlorifiColors.grey,
        showSimpleAppBar: !faqCategoriesController.isLoggedIn,
        appBar: GlorifiAppBar(
          title: 'Request a Callback',
          disableLeading: true,
          trailing: Trailing(
            text: 'Cancel',
            onTap: Get.back,
          ),
        ),
        body: _pageBody(sizingInfo),
      );
    });
  }

  Widget _pageBody(AdaptiveSizingInfo sizingInfo) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: sizingInfo.isDesktop
            ? 200.w
            : sizingInfo.isTablet
                ? 34.5.w
                : 24.w,
      ),
      child: Column(
        children: [
          if (sizingInfo.isDesktop && !sizingInfo.isNativeMobile)
            PageHeader(
              headerTitle: 'Request a Callback',
              headerButtonTitle: "Cancel",
              showWebPageFont: true,
              headerButtonOnTap: Get.back,
            ),
          if (sizingInfo.isWebMobile && !sizingInfo.isNativeMobile)
            PageHeader(
              headerTitle: 'Request a Callback',
              headerButtonTitle: "Cancel",
              showWebMobileVersionFont: true,
              headerButtonOnTap: Get.back,
            ),
          SizedBox(
              height: (sizingInfo.isNativeMobile)
                  ? 108.h
                  : (sizingInfo.isDesktop)
                      ? 32.h
                      : 66.h),
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1024),
              child: AdaptiveGrid(
                children: [
                  if (sizingInfo.isDesktop)
                    AdaptiveGridItem(
                      desktop: 10,
                    ),
                  AdaptiveGridItem(
                    nativeMobile: 100,
                    desktop: 80,
                    tablet: 100,
                    webMobile: 100,
                    child: Column(
                      crossAxisAlignment: (sizingInfo.isDesktop)
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            GlorifiAssets.headset,
                            height: sizingInfo.isNativeMobile ? 80.h : 96.h,
                            width: sizingInfo.isNativeMobile ? 80.h : 96.h,
                            color: GlorifiColors.black.withOpacity(0.75),
                          ),
                        ),
                        SizedBox(
                          height: (sizingInfo.isDesktop) ? 24.h : 68.h,
                        ),
                        Text(
                          'Please confirm the number to receive a callback ',
                          textAlign: TextAlign.start,
                          style: smallRegular16Primary(
                            color: GlorifiColors.darkBlue,
                          ),
                        ),
                        SizedBox(
                          height: (sizingInfo.isDesktop) ? 44.h : 16.h,
                        ),
                        Obx(
                          () => FaqTextField(
                            title: 'Phone Number',
                            minLines: 1,
                            hint: '555-555-5555',
                            hintStyle: formInput(
                              color: GlorifiColors.textColorGrey,
                            ),
                            controller: controller.phoneController,
                            errorText: controller.phoneError.value,
                            onChanged: (val) => controller.onNumberChanged(val),
                            isValid: controller.phoneIsNotValid.value,
                            textInputType: TextInputType.number,
                            suffixWidget: Visibility(
                              visible: !controller.hideClearButton.value,
                              child: InputSuffixIcon(
                                iconData: Icons.close,
                                iconColor: GlorifiColors.midnightBlue,
                                onTap: () {
                                  controller.clearField();
                                },
                              ),
                            ),
                            inputFormatter: <TextInputFormatter>[
                              CardFormatter(
                                sample: 'xxx-xxx-xxxx',
                                separator: '-',
                              ),
                              LengthLimitingTextInputFormatter(12),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: (sizingInfo.isDesktop) ? 32.h : 60.h,
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.pageState == PageState.DEFAULT,
                            child: AppButton(
                              backgroundColor:
                                  GlorifiColors.primaryDarkButtonColor,
                              textColor: GlorifiColors.white,
                              label: 'Continue',
                              textStyle: bodyBold18Primary(
                                color: GlorifiColors.white,
                              ),
                              onTap: () => controller
                                  .validateCallBack(toBeginningOfSentenceCase(
                                category.toLowerCase().contains('general')
                                    ? 'general'
                                    : category,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (sizingInfo.isDesktop)
                    AdaptiveGridItem(
                      desktop: 10,
                    ),
                ],
              ))
        ],
      ),
    );
  }
}
