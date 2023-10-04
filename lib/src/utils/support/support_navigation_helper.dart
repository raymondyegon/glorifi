import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/contact_support_category_screen.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/contact_support_screen.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/guest_user_form_screen.dart';
import 'package:glorifi/src/feature/support/faq/faq_answer_screen.dart';
import 'package:glorifi/src/feature/support/faq/faq_categories_page.dart';
import 'package:glorifi/src/feature/support/faq/faq_listing_screen.dart';
import 'package:glorifi/src/feature/support/faq/faq_search_screen.dart';
import 'package:glorifi/src/feature/support/message_us/message_us_screen.dart';
import 'package:glorifi/src/feature/support/success_error_empty_state/contact_support_error_screen.dart';
import 'package:glorifi/src/feature/support/success_error_empty_state/email_sent_error_screen.dart';
import 'package:glorifi/src/feature/support/support_widgets/chat_webview.dart';

import '../../controllers/support/faq_categories_controller.dart';
import '../../core/data_helper.dart';
import '../../feature/support/callback/callback_success_screen.dart';
import '../../feature/support/callback/request_call_back_screen.dart';
import '../../feature/support/success_error_empty_state/email_sent_success_screen.dart';
import '../../routes/app_pages.dart';

class SupportNavigationHelper {
  static navigateToList(String? category) async {
    Map<String, dynamic> categories =
        await DataHelperImpl.instance.cacheHelper.getFAQCategories();

    category = category?.toLowerCase();

    String? id;
    if (category != null && categories.containsKey(category)) {
      id = categories[category];
      loadBottomSheet(id: id, category: category);
    } else {
      loadBottomSheet(category: category);
    }
  }

  static loadBottomSheet({String? id, String? category}) {
    Get.bottomSheet(
      BottomSheetBase(
        id: id,
        category: category,
      ),
      ignoreSafeArea: false,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
    );
  }
}

class BottomSheetBase extends StatefulWidget {
  String? id, category;

  BottomSheetBase({Key? key, this.id, this.category}) : super(key: key);

  @override
  _BottomSheetBaseState createState() => _BottomSheetBaseState();
}

class _BottomSheetBaseState extends State<BottomSheetBase> {
  late List<Widget> pages;
  late FAQCategoriesController controller;

  @override
  void initState() {
    /// From Support main entry point category will be null which helps us
    /// to decide if we are coming from product section or via main entry point
    controller = Get.put(FAQCategoriesController(
      isBottomSheet: true,
      initFromFAQListingScreen: !(widget.category == null),
      selectedCategoryKey: widget.id,
    ));
    controller.selectedCategoryTitle = widget.category;
    controller.selectedCategoryKey = widget.id;

    if (widget.category != null) {
      controller.navigationStack[0] = 1;
    }

    pages = [
      // FAQCategoryListingScreen(),
      // FAQListingScreen(),
      // FAQAnswerScreen(),
      // FaqSearchScreen(isBottomSheet: true),
      // ContactSupportCategoryScreen(),
      // ContactSupportScreen(),
      // GuestUserFormScreen(),
      // MessageUsScreen(),
      // ChatWebView()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.navigationStack.isEmpty) {
        Get.back();
        return Container();
      } else {
        switch (controller.navigationStack[0]) {
          case 0:
            return FAQCategoryListingScreen();
          case 1:
            return FAQListingScreen();
          case 2:
            return FAQAnswerScreen();
          case 3:
            return FaqSearchScreen(isBottomSheet: true);
          case 4:
            return ContactSupportCategoryScreen();
          case 5:
            return ContactSupportScreen();
          case 6:
            return GuestUserFormScreen();
          case 7:
            return MessageUsScreen();
          case 8:
            return ChatWebView();
          case 9:
            return RequestCallbackScreen();
          case 10:
            return CallbackSuccessScreen();
          case 11:
            return EmailSuccessScreen();
          case 12:
            return EmailSentErrorScreen();
          case 13:
            return ContactSupportErrorScreen();
          default:
            return FAQCategoryListingScreen();
        }
        // return pages[controller.navigationStack[0]];
      }
    });
  }
}
