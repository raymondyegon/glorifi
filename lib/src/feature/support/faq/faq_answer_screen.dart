import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/data_helper.dart';
import '../../../font_style_global.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';
import '../../../utils/login_status/login_status.dart';
import '../support_widgets/cant_find_widget.dart';
// import 'package:universal_html/html.dart' as html;

class FAQAnswerScreen extends StatelessWidget {
  late FAQCategoriesController controller;
  String question = '';
  String answer = '';
  String category = '';


  FAQAnswerScreen({Key? key}) : super(key: key) {
    controller = Get.find<FAQCategoriesController>();
    getFaqAnswer();

  }

  @override
  Widget build(BuildContext context) {

    question = controller.selectedQuestion;
    answer = controller.selectedAnswer;
    category = controller.selectedCategoryTitle ?? '';

    return AdaptiveScaffold(
      backgroundColor: GlorifiColors.basicLightGrey,
      showSimpleAppBar: !controller.isLoggedIn,
      appBar: GlorifiAppBar(
        title: '$category Support',
        leading: Leading(
          onTap: () {
            if (controller.isBottomSheet) {
              controller.navigationStack.removeAt(0);
              controller.update();
            } else {
              Get.back();
            }
          },
        ),
        trailing: Trailing(
          text: 'Close',
          onTap: () {
            controller.isBottomSheet
                ? Get.back()
                : Get.until((route) => !Get.currentRoute.contains('faq'));
          },
        ),
      ),
      body: body(context),
    );
  }

  body(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.isDesktop) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
                  headerTitle: '$category Support',
                  showWebPageFont: true,
                  showTrailingButton: false,
                  horizontalPadding: 200.w),
              Text(
                question,
                textAlign: TextAlign.start,
                style: headlineSemiBold31Primary(
                  color: GlorifiColors.cornflowerBlue,
                ),
              ).paddingOnly(top: 62.h, bottom: 24.h, left: 300.w, right: 300.w),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    HtmlWidget(
                      answer,
                      textStyle: bodyRegular18Primary(
                        color: GlorifiColors.midnightBlueColor,
                      ),
                      onTapUrl: (url) async {
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                        return true;
                      },
                    ).paddingSymmetric(
                      horizontal: 300.w,
                      vertical: 24.h,
                    ),
                  ],
                ),
              ),
              CantFIndWidget(
                label: "Can't find what you need?",
                isDesktop: true,
                onTap: () {
                  if (controller.isBottomSheet) {
                    controller.navigationStack.insert(0, ContactSupportCategoryScreen);
                    controller.update();
                  }
                  else {
                    Get.toNamed(
                        Routes.contactSupportCategoryScreen,
                        preventDuplicates: false);
                  }
                },
                textStyle: bodyRegular18Primary(
                  color: GlorifiColors.darkBlue,
                ),
              ),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!sizingInfo.isNativeMobile)
              PageHeader(
                  headerTitle: '$category Support',
                  showTrailingButton: false,
                  showWebMobileVersionFont: true,
                  horizontalPadding: sizingInfo.isTablet ? 34.5.w : 24.5.w),
            Text(
              question,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: GlorifiColors.biscayBlue,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ).paddingOnly(top: 32.w, bottom: 16.h, left: 24.w, right: 24.w),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  HtmlWidget(
                    '<html><head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></head><body>$answer</body></html>',
                    textStyle: TextStyle(fontSize: 16.sp),
                    onTapUrl: (url) async {
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                      return true;
                    },
                  ).paddingSymmetric(
                    horizontal: 24.w,
                  ),
                ],
              ),
            ),
            CantFIndWidget(
              label: "Can't find what you need?",
              onTap: () {
                if (controller.isBottomSheet) {
                  controller.navigationStack.insert(0, ContactSupportCategoryScreen);
                  controller.update();
                } else {
                  Get.toNamed(Routes.contactSupportCategoryScreen,
                      preventDuplicates: false);
                }
              },
              textStyle: bodyRegular18Primary(
                color: GlorifiColors.darkBlue,
              ),
            ),
          ],
        );
      },
    );
  }


  Future<void> getFaqAnswer() async {

        if(controller.selectedAnswer != null
            && !controller.selectedAnswer.isEmpty){
          answer = controller.selectedAnswer;
        } else {
          answer = Get.parameters['answer']!;
          controller.selectedAnswer = answer;
        }

        if(controller.selectedQuestion != null
            && !controller.selectedQuestion.isEmpty){
          question = controller.selectedQuestion;
        } else {
          question = Get.parameters['question']!;
          controller.selectedQuestion = question;
        }

        if(controller.selectedCategoryTitle != null
            && !controller.selectedCategoryTitle!.isEmpty){
          category =controller.selectedCategoryTitle ?? '';
        } else {
          category = Get.parameters['categoryTitle']!;
          controller.selectedCategoryTitle = category;
        }

  }

}
