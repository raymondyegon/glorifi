import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/controllers/support/support_navigation_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/support/support_widgets/chat_webview.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/constants.dart';

class GuestUserController extends BaseController {
  // late var controller ;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  RxBool nameIsNotValid = false.obs;
  RxBool emailIsNotValid = false.obs;
  RxBool phoneIsNotValid = false.obs;
  RxString nameError = ''.obs;
  RxString emailError = ''.obs;
  RxString phoneError = ''.obs;

  PageState pageState = PageState.DEFAULT;
  late SupportNavigationController supportNavigationController;
  late FAQCategoriesController faqCategoriesController;

  @override
  void onInit() {
    nameController.addListener(update);
    emailController.addListener(update);
    phoneController.addListener(update);

    //todo make this find
    supportNavigationController = Get.put(SupportNavigationController());
    faqCategoriesController = Get.find<FAQCategoriesController>();
    // controller = Get.isRegistered<GuestUserController>()
    //     ? Get.find<GuestUserController>()
    //     : Get.put(GuestUserController());

    super.onInit();
  }

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();

    super.dispose();
  }

  onNameChanged(value) {
    if (value!.isNotEmpty && value.length > 0) {
      nameIsNotValid.value = false;
      nameError.value = '';
    }
  }

  onEmailChanged(value) {
    if (value!.isNotEmpty && value.length > 0) {
      emailIsNotValid.value = false;
      emailError.value = '';
    }
  }

  onNumberChanged(value) {
    if (value!.isNotEmpty && value.length > 0) {
      phoneIsNotValid.value = false;
      phoneError.value = '';
      update();
    }
  }

  validate(method, category) async {
    if (nameController.text.isEmpty) {
      nameError.value = 'Please enter a valid name';
      nameIsNotValid.value = true;
      update();
    }
    if (emailController.text.isEmpty || !emailController.text.isValidEmail()) {
      emailError.value = 'Please enter a valid email';
      emailIsNotValid.value = true;
      update();
    }
    if (phoneController.text.isEmpty ||
        !(phoneController.text.replaceAll(RegExp('[^0-9]'), '').length == 10)) {
      phoneError.value = 'Please enter a valid phone number';
      phoneIsNotValid.value = true;
      update();
    }

    if (nameController.text.isNotEmpty &&
        emailController.text.isValidEmail() &&
        phoneController.text.isNotEmpty &&
        (phoneController.text.replaceAll(RegExp('[^0-9]'), '').length == 10)) {
      pageState = PageState.SUCCESS;
      update();

      nameIsNotValid.value = false;
      emailIsNotValid.value = false;
      phoneIsNotValid.value = false;
      nameError.value = '';
      emailError.value = '';
      phoneError.value = '';

      if (method == 'chat') {
        Map<String, dynamic> arguments = {
          'RoutingKey': category,
          'MemberEmail': emailController.text,
          'MemberName': nameController.text,
          'MemberPhone': phoneController.text,
          'MemberID': '',
        };

        //todo bottomsheet flow
        if (faqCategoriesController.isBottomSheet) {
          supportNavigationController.webViewArguments = arguments;
          faqCategoriesController.navigationStack.insert(0, ChatWebViewScreen);
          supportNavigationController.update();
          faqCategoriesController.update();
        } else {
          Get.to(ChatWebView(), arguments: arguments);
        }
      } else if (method == 'callback') {
        Map<String, dynamic> params = {
          "flowId": "5fbf74c6-0229-4f7e-a17e-5319f2d13291",
          "provider": "GlorifyMobileApp",
          "attributes": {
            'RoutingType': 'Callback',
            'RoutingKey': category,
            'CallbackUserName': nameController.text,
            'CallbackNumber':
                phoneController.text.replaceAll(RegExp('[^0-9]'), ''),
            'FinalIntent': category,
            'MemberID': '',
          },
          "direction": "INBOUND",
        };

        await updateScheduleInfoApi(params);
      } else if (method == 'email') {
        //todo bottomsheet flow
        if (faqCategoriesController.isBottomSheet) {
          faqCategoriesController.selectedSupportCategoryTitle = category;
          faqCategoriesController.name = nameController.text;
          faqCategoriesController.email = emailController.text;
          faqCategoriesController.phone = phoneController.text;

          faqCategoriesController.navigationStack.insert(0, MessageUsScreen);
          faqCategoriesController.update();
        } else {
          Get.toNamed(Routes.messageUsScreen, arguments: {
            'name': nameController.text,
            'email': emailController.text,
            'phone': phoneController.text,
            'category': category,
          });
        }
      }
      pageState = PageState.DEFAULT;
      update();
    }
  }

  updateScheduleInfoApi(Map<String, dynamic> params) async {
    var response =
        await DataHelperImpl.instance.apiHelper.updateScheduleInfo(params);

    response.fold((l) => throw l.errorMessage, (r) {
      if (r['success']) {
        if (faqCategoriesController.isBottomSheet) {
          faqCategoriesController.navigationStack
              .insert(0, CallBackSuccessScreen);
          faqCategoriesController.update();
        } else {
          Get.toNamed(Routes.callbackSuccess);
        }
      }
    });
  }
}

extension StringExtension on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}
