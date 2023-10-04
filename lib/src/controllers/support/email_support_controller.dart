import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/support/support_models/support_main_page_content_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:intl/intl.dart';

import 'faq_categories_controller.dart';

class EmailSupportController extends BaseController {
  List<SupportMainContentModel> supportContents = SupportDummyList.list;
  TextEditingController messageController = TextEditingController();
  late FAQCategoriesController faqCategoriesController ;
  final emailFocusNode = FocusNode();

  String _category ='' ;

  RxList faqCategories = [].obs;
  RxBool isValid = false.obs;
  RxString error = ''.obs;
  String toEmailAddress = '';

  PageState pageState = PageState.DEFAULT;

  final dataImpl = DataHelperImpl.instance;

  RxList list = [].obs;

  Map<String, String> librariesMap = {};

  @override
  void onInit() {
    faqCategoriesController  = Get.find<FAQCategoriesController>();
    getListFromCache();
    messageController.addListener(update);
    super.onInit();
  }

  final TextEditingController searchController = TextEditingController();

  submitMessage(
    name,
    email,
    phone,
    memberID,
    category,
  ) async {
    var dataHelper = await DataHelperImpl.instance;
    Map<String, dynamic> params = {};
    if (messageController.text.trim().isNotEmpty) {
      pageState = PageState.SUCCESS;
      update();

      // for unauthenticated users , the number will be passed from form, else take it from profile Controller
      String parsedPhone = phone.replaceAll(RegExp('[^0-9]'), '');
      _category= category;
      String text =
          'Member ID: ${memberID ?? ''}\nName: ${name}\nPhone Number: ${parsedPhone}\nTopic: ${toBeginningOfSentenceCase(category)}\n\nQuestion: \n${messageController.text.toString()}\n\n';

      params = {
        "text": text,
        'line_of_business': toBeginningOfSentenceCase(category),
        'from_email': email
      };

      var response = await dataHelper.apiHelper.sendEmailToGenesys(params);

      response.fold((l) {
        if (faqCategoriesController.isBottomSheet) {
          faqCategoriesController.emailSupportRequestParams = params;
          faqCategoriesController.navigationStack.insert(0, EmailSentErrorScreen);
          faqCategoriesController.update();
        }
        else {
          Get.toNamed(Routes.emailSentError, arguments: {
            'params': params,
          });
        }
        pageState = PageState.DEFAULT;
        update();
      }, (r) {
        if (r['success']) {

          if (faqCategoriesController.isBottomSheet) {
            faqCategoriesController.navigationStack.insert(0, EmailSentSuccessScreen);
            faqCategoriesController.update();
          }
          else {
            Get.toNamed(Routes.emailSentSuccessScreen);
          }
        }
      });
    } else {
      isValid.value = true;
      error.value = 'Please enter a message';
      update();
    }
  }

  void getListFromCache() async {
    Map<String, dynamic> categories =
        await DataHelperImpl.instance.cacheHelper.getFAQCategories();

    categories.forEach((key, value) {
      list.add(key);
    });

    update();
  }

  getCatogery()
  {
  return _category;
  }

  onChanged(String? value) {
    if (value!.isNotEmpty && value.trim().length > 0) {
      isValid.value = false;
      error.value = '';
      update();
    }
  }
}
