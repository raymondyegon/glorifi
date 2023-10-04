import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/support/success_error_empty_state/faq_category_empty_state.dart';
import 'package:glorifi/src/feature/support/support_widgets/faq_list_item.dart';
import 'package:glorifi/src/feature/support/support_widgets/faq_loading_shimmer.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';
import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../../utils/constants.dart';
import '../../../utils/login_status/login_status.dart';
import '../support_widgets/cant_find_widget.dart';
import '../support_widgets/faq_list_item.dart';


class FAQListingScreen extends StatelessWidget {
  String? libraryKey;
  String? title;

  FAQListingScreen({Key? key}) : super(key: key) {
    libraryKey = Get.parameters['key'];
    title = Get.parameters['title'];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FAQCategoriesController>(
      init:
          FAQCategoriesController(initFromFAQListingScreen: libraryKey != null)
            ..setLibraryKeyandTitle(libraryKey, title),
      builder: (controller) {
        return AdaptiveBuilder(
          builder: (BuildContext context, AdaptiveSizingInfo sizingInfo) {
            return sizingInfo.isDesktop
                ? AdaptiveScaffoldWeb(showSimpleAppBar: !controller.isLoggedIn).getScaffold(
                    context: context,
                    backgroundColor: GlorifiColors.lighterGrey,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageHeader(
                            headerTitle:
                                '${title ?? controller.selectedCategoryTitle?.capitalizeFirst ?? 'FAQ'} Support',
                            showTrailingButton: false,
                            showWebPageFont: true,
                            horizontalPadding: 200.w),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.questions.length == 0
                                ? Container().paddingSymmetric(
                                    vertical: 50.h,
                                    horizontal: 24.w,
                                  )
                                : faqTitle(context).paddingSymmetric(
                                    vertical: 50.h,
                                    horizontal: 24.w,
                                  ),
                            controller.loading.value
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: 6,
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) {
                                        return FaqListLoadingShimmer(
                                          height: 64.h,
                                          baseColor: Colors.white60,
                                          highlightColor: GlorifiColors
                                              .greyBgColor
                                              .withOpacity(
                                            0.3,
                                          ),
                                          rounded: true,
                                        ).paddingSymmetric(
                                          vertical: 8.h,
                                        );
                                      },
                                    ).paddingSymmetric(
                                      horizontal: 24.w,
                                    ),
                                  )
                                : controller.questions.isNotEmpty
                                    ? Expanded(
                                        child: Column(
                                          children: [
                                            _buildQuestionsList(
                                              context,
                                              controller,
                                              sizingInfo,sizingInfo.isNativeMobile
                                            ),
                                          ],
                                        ),
                                      )
                                    : Expanded(
                                        child: FaqCategoryErrorState(),
                                      ),
                          ],
                        ).paddingOnly(
                          bottom: 80.h,
                          left: 250.w,
                          right: 250.w,
                        )),
                        _buildCantFindWhatYouNeed(controller, sizingInfo),
                      ],
                    ),
                  )
                : AdaptiveScaffold(
                    appBar: GlorifiAppBar(
                      title:
                          '${title ?? controller.selectedCategoryTitle?.capitalize ?? 'FAQ'} Support',
                      leading: Leading(onTap: () {
                        if (controller.isBottomSheet) {
                          controller.navigationStack.removeAt(0);
                          controller.update();
                        } else {
                          Get.back();
                        }
                      }),
                      trailing: Trailing(
                        text: 'Close',
                        onTap: () {
                          controller.isBottomSheet
                              ? Get.back()
                              : Get.until(
                                  (route) => !Get.currentRoute.contains('faq'),
                                );
                        },
                      ),
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (!sizingInfo.isNativeMobile)
                          PageHeader(
                            headerTitle:
                                '${title ?? controller.selectedCategoryTitle ?? 'FAQ'} Support',
                            showTrailingButton: false,
                            showWebMobileVersionFont: true,
                            horizontalPadding:
                                sizingInfo.isTablet ? 34.5.w : 24.5.w,
                          ),
                        controller.questions.length == 0
                            ? Container().paddingSymmetric(
                                vertical: 24.h,
                                horizontal: 24.w,
                              )
                            : faqTitle(context).paddingSymmetric(
                                vertical: 24.h,
                                horizontal: 24.w,
                              ),
                        controller.loading.value
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: 6,
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    return FaqListLoadingShimmer(
                                      height: 64.h,
                                      baseColor: Colors.white60,
                                      highlightColor:
                                          GlorifiColors.greyBgColor.withOpacity(
                                        0.3,
                                      ),
                                      rounded: true,
                                    ).paddingSymmetric(
                                      vertical: 8.h,
                                    );
                                  },
                                ).paddingSymmetric(
                                  horizontal: 24.w,
                                ),
                              )
                            : controller.questions.isNotEmpty
                                ? Expanded(
                                    child: Column(
                                      children: [
                                        _buildQuestionsList(context,
                                            controller,
                                            sizingInfo,
                                            sizingInfo.isNativeMobile),
                                        _buildCantFindWhatYouNeed(
                                            controller, sizingInfo),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: FaqCategoryErrorState(),
                                  ),
                      ],
                    ),
                  );
          },
        );
      },
    );
  }


  Widget _buildQuestionsList(
      context, controller, AdaptiveSizingInfo sizingInfo,bool isNativeMobile) {

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Column(
          children: List.generate(
            controller.questions.length,
            (index) {
              return FaqListItemWidget(
                label: controller.questions[index].title,
                textColor: GlorifiColors.defaultGradientStartColor,
                sizingInfo: sizingInfo,
                onTap: () {
                  gotoFaqAnswer(
                    controller,
                    controller.questions[index].title,
                    controller.questions[index].answer,
                    controller.questions[index].sId,isNativeMobile
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCantFindWhatYouNeed(controller, AdaptiveSizingInfo sizingInfo) {
    return InkWell(
      onTap: () {
        if (controller.isBottomSheet) {
          controller.navigationStack.insert(0, ContactSupportCategoryScreen);
          controller.update();
        } else {
          Get.toNamed(Routes.contactSupportCategoryScreen,
              preventDuplicates: false);
        }
      },
      child: Material(
        elevation: 20,
        child: Container(
          color: GlorifiColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: sizingInfo.isDesktop ? 200.w : 24.w,
          ).copyWith(
            top: 16.h,
            bottom: 32.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  "Can't find what you need?",
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: bodyRegular18Primary(
                    color: GlorifiColors.darkBlue,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: GlorifiColors.darkBlue,
              ),
            ],
          ),
        ),
      ) /*.paddingOnly(
        bottom: 16.h,
      )*/
      ,
    );
  }

  void gotoFaqAnswer(
      FAQCategoriesController controller, title, answer, gemId, bool isNativeMobile) async {
      var response = await DataHelperImpl.instance.apiHelper.getFaqAnswer(gemId);
      response.fold((l) {}, (r) {
        answer = r;
      });
      controller.selectedQuestion = title ?? '';
      controller.selectedAnswer = answer;
      if (controller.isBottomSheet) {
        controller.navigationStack.insert(0, 2);
        controller.update();
      } else {
        // Map<String, String> result = {"answer" : answer,"question": title , "categoryTitle" : controller.selectedCategoryTitle!};
        // DataHelperImpl.instance.cacheHelper.saveFAQAnswer(result);
        Get.toNamed(Routes.faqAnswerScreen, parameters: {"answer" : answer,
          "question": title , "categoryTitle" : controller.selectedCategoryTitle!});
      }
  }

  Widget faqTitle(context) {
    return Text(
      'FAQs',
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: GlorifiColors.biscayBlue,
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
