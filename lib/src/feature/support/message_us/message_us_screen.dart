import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/email_support_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../../controllers/support/faq_categories_controller.dart';
import 'msg_field.dart';

class MessageUsScreen extends GetView<EmailSupportController> {
  late FAQCategoriesController fAQCategoriesController;

  MessageUsScreen({Key? key}) : super(key: key) {
    fAQCategoriesController = Get.find<FAQCategoriesController>();
  }

  @override
  Widget build(BuildContext context) {
    var name = Get.arguments == null
        ? fAQCategoriesController.name
        : Get.arguments['name'] ?? '';
    var email = Get.arguments == null
        ? fAQCategoriesController.email
        : Get.arguments['email'] ?? '';
    var phone = Get.arguments == null
        ? fAQCategoriesController.phone
        : Get.arguments['phone'] ?? '';
    var category = Get.arguments == null
        ? fAQCategoriesController.selectedSupportCategoryTitle
        : Get.arguments['category'] ?? '';
    var memberID = Get.arguments == null
        ? fAQCategoriesController.memberID
        : Get.arguments['memberID'] ?? '';

    return AdaptiveScaffold(
      backgroundColor: GlorifiColors.bgGray,
      resizeToAvoidBottomInset: false,
      showSimpleAppBar: !fAQCategoriesController.isLoggedIn,
      appBar: GlorifiAppBar(
        title: TextConstants.emailSupport,
        elevation: 3,
        disableLeading: true,
        textStyle: bodySemiBold18Primary(color: GlorifiColors.midnightBlue),
        trailing: Trailing(
          onTap: () {
            if (fAQCategoriesController.isBottomSheet) {
              fAQCategoriesController.navigationStack.removeAt(0);
              fAQCategoriesController.update();
            } else {
              Get.back();
            }
          },
          text: 'Cancel',
        ),
      ),
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          double responsiveHorizontalPadding = sizingInfo.isDesktop
              ? 200.w
              : sizingInfo.isTablet
                  ? 34.5.w
                  : 24.w;
          return SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: responsiveHorizontalPadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1024),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sizingInfo.isDesktop && sizingInfo.isTablet
                        ? 34.h
                        : sizingInfo.isWebMobile
                            ? 22.h
                            : 0,
                  ),
                  if (!sizingInfo.isNativeMobile)
                    PageHeader(
                      horizontalPadding: 0,
                      headerTitle: 'Email Support',
                      showWebPageFont: true,
                      showTrailingButton: false,
                    ),
                  Text(
                    TextConstants.haveAQuestion,
                    textAlign: TextAlign.start,
                    style: smallRegular16Primary(
                      color: GlorifiColors.midnightBlue,
                    ),
                  ).paddingOnly(
                    top: sizingInfo.isDesktop && sizingInfo.isTablet
                        ? 34.h
                        : sizingInfo.isWebMobile
                            ? 38.h
                            : 16.h,
                  ),
                  Center(
                    child: MsgField(
                      name: name,
                      email: email,
                      phone: phone,
                      category: category.toString(),
                      memberID: memberID,
                      sizingInfo: sizingInfo,
                    ).paddingOnly(
                      top: sizingInfo.isDesktop && sizingInfo.isTablet
                          ? 34.h
                          : 16.h,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
