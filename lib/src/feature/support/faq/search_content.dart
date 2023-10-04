import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/controllers/support/faq_search_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/support/support_widgets/search_list_item.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

import '../../../utils/constants.dart';

class SearchContent extends GetView<FaqSearchController> {
  late FAQCategoriesController supportMainController;
  late FaqSearchController controller;

  SearchContent({
    Key? key,
    required this.libraryIDs,
    required this.sizingInfo,
  }) : super(key: key) {
    supportMainController = Get.find<FAQCategoriesController>();
    controller = Get.put(FaqSearchController());
  }

  final List libraryIDs;
  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return _buildSearchBox(controller, context);
        }),
        SizedBox(
          height: 25.h,
        ),
        Obx(() {
          return Visibility(
              visible: controller.pageState == PageState.LOADING,
              child: _buildLoadingIndicator());
        }),
        Obx(() {
          return Visibility(
            visible: controller.pageState == PageState.SUCCESS,
            child: Column(
              children: [
                controller.suggestions.length == 0
                    ? _buildNoResultFound()
                    : _buildSuggestionsList(context, controller),
                _buildCantFindWhatYouNeed()
              ],
            ),
          );
        }),
        Obx(
          () {
            return Visibility(
              visible: controller.pageState == PageState.ERROR,
              child: _buildErrorFeedback(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildErrorFeedback() {
    return Padding(
      padding: EdgeInsets.only(
        top: 90.h,
        bottom: 9.h,
      ),
      child: Ripple(
        onTap: () {
          if (supportMainController.isBottomSheet) {
            supportMainController.navigationStack
                .insert(0, ContactSupportCategoryScreen);
            supportMainController.update();
          } else {
            Get.toNamed(Routes.contactSupportCategoryScreen,
                preventDuplicates: false);
          }
        },
        child: Column(
          children: [
            Text(
              "We can’t load FAQs at this time.",
              style: headlineSemiBold31Primary(
                color: GlorifiColors.midnightBlue,
              ),
            ).paddingOnly(
              bottom: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    "Can't find what you need?",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: bodySemiBold18Primary(
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
          ],
        ),
      ),
    );
  }

  Widget _buildCantFindWhatYouNeed() {
    return InkWell(
      onTap: () {
        if (supportMainController.isBottomSheet) {
          supportMainController.navigationStack
              .insert(0, ContactSupportCategoryScreen);
          supportMainController.update();
        } else {
          Get.toNamed(Routes.contactSupportCategoryScreen,
              preventDuplicates: false);
        }
      },
      child: Container(
        color: GlorifiColors.lightWhite,
        padding: EdgeInsets.only(
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
                style: bodySemiBold18Primary(
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
    );
  }

  Widget _buildNoResultFound() {
    return Padding(
      padding: EdgeInsets.only(top: 21.h, bottom: 9.h),
      child: Text(
        "Sorry, we couldn’t find that question. Please try searching again.",
        style: headlineRegular21Primary(
          color: GlorifiColors.midnightBlue,
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 65,
      width: 65,
      child: GlorifiSpinner(
        size: 65,
      ),
    );
  }

  Widget _buildSearchBox(FaqSearchController controller, BuildContext context) {
    final _borderRadius = 5.r;
    return Container(
      decoration: BoxDecoration(
        color: GlorifiColors.lightWhite,
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        boxShadow: [
          BoxShadow(
            color: GlorifiColors.black.withOpacity(0.10),
            spreadRadius: 0,
            blurRadius: 10.r,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: controller.typeAheadController,
        autofocus: true,
        onChanged: (val) {
          if (val.length >= 2) {
            controller.getSuggestions(pattern: val, libraryIDs: libraryIDs);
          } else if (val.isEmpty) {
            controller.clearSearchResult();
          }
        },
        style: TextStyle(
          color: GlorifiColors.textColorBlack,
        ),
        decoration: InputDecoration(
          hintText: 'Ask a question',
          prefixIcon:
              SvgPicture.asset('assets/icons/search_icon.svg').paddingOnly(
            left: 16.w,
            right: 16.w,
          ),
          suffixIcon: controller.textControllerValue.value.isNotEmpty
              ? IconButton(
                  onPressed: () => {
                    controller.typeAheadController.clear(),
                    controller.clearSearchResult(),
                  },
                  icon: Icon(
                    Icons.clear,
                    color: GlorifiColors.textFieldTextColor,
                  ),
                )
              : SizedBox.shrink(),
          alignLabelWithHint: true,
          fillColor: Colors.white,
          hintStyle: smallRegular16Primary(
            color: GlorifiColors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: GlorifiColors.greyBgColor.withOpacity(0.2), width: 2.0),
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: GlorifiColors.greyBgColor.withOpacity(0.2), width: 2.0),
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: GlorifiColors.greyBgColor.withOpacity(0.5),
                  width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
        ),
      ),
    );
  }

  Widget _buildSuggestionsList(context, controller) {
    return Column(
      children: List.generate(
        controller.suggestions.length,
        (index) {
          return SearchListItem(
            label: RichText(
              text: TextSpan(
                text: '', //${controller.suggestions[index].title}
                style: smallRegular16Primary(
                  color: GlorifiColors.midnightBlue,
                ),
                children:
                    _getList(context, controller.suggestions[index].title),
              ),
            ),
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              supportMainController.selectedQuestion =
                  controller.suggestions[index].title;
              supportMainController.selectedCategoryTitle = '';

              var response = await DataHelperImpl.instance.apiHelper
                  .getFaqAnswer(controller.suggestions[index].gemID);
              response.fold((l) {}, (r) {
                supportMainController.selectedAnswer = r.toString().trimLeft();
              });
              if (supportMainController.isBottomSheet) {
                supportMainController.navigationStack
                    .insert(0, FAQAnswerScreen);
                supportMainController.update();
              } else {
                Get.toNamed(Routes.faqAnswerScreen,parameters: {"answer" : supportMainController.selectedAnswer,
                    "question":  supportMainController.selectedQuestion , "categoryTitle" : ''});
              }
            },
          );
        },
      ),
    );
  }

  List<TextSpan> _getList(BuildContext context, String result) {
    List<TextSpan> mList = [];
    String searchKey = controller.textControllerValue.value.toLowerCase();
    result.split(' ').forEach((word) {
      bool isContain = false;
      searchKey.split(' ').forEach((key) {
        if (key.isNotEmpty && !isContain) {
          isContain = word.toLowerCase().contains(key.toLowerCase());
        }
      });
      TextStyle style = isContain
          ? smallBold16Primary(
              color: GlorifiColors.midnightBlue,
            )
          : smallRegular16Primary(
              color: GlorifiColors.midnightBlue,
            );
      mList.add(
        TextSpan(text: '$word ', style: style),
      );
    });

    return mList;
  }
}
