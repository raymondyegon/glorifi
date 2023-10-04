import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/member_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:glorifi/src/utils/login_status/login_status.dart';

import 'faq_categories_controller.dart';

class CallBackController extends BaseController {
  var controller = Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  var member = Get.isRegistered<MemberController>()
      ? Get.find<MemberController>()
      : Get.put(MemberController());

  late FAQCategoriesController faqCategoriesController;

  final TextEditingController phoneController = TextEditingController();
  RxBool phoneIsNotValid = false.obs;
  RxBool hideClearButton = false.obs;

  RxString phoneError = ''.obs;

  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);

  get pageState => _pageStateController.value;

  @override
  void onInit() {
    phoneController.addListener(update);
    preFillPhoneController();

    faqCategoriesController = Get.find<FAQCategoriesController>();

    super.onInit();
  }

  clearField() {
    phoneController.clear();
    hideClearButton.value = true;
  }

  preFillPhoneController() {
    if (controller.userProfile.phoneNumber.isNotEmpty) {
      phoneController.text = controller.userProfile.phoneNumber;
    }
  }

  //todo not used . Remove if not necessary
  navigateToEmailSupport(category) async {
    CheckLoginStatus.checkLoginStatus(
      () => Get.toNamed(
        Routes.messageUsScreen,
        arguments: {
          'category': category,
          'name': controller.getUserFullName(),
          'email': controller.userProfile.email,
          'phone': controller.userProfile.phoneNumber,
        },
      ),
      () => Get.toNamed(
        Routes.guestUserFormScreen,
        arguments: {
          'category': category,
        },
      ),
    );
  }

  onNumberChanged(value) {
    if (value!.isNotEmpty && value.length > 0) {
      hideClearButton.value = false;
      phoneIsNotValid.value = false;
      phoneError.value = '';
    }
  }

//todo not used. Remove if not required.
  navigateToCallBackScreen(category, callback) {
    CheckLoginStatus.checkLoginStatus(
      () => Get.toNamed(
        Routes.requestCallBack,
        arguments: {
          'category': category,
        },
      ),
      () => Get.toNamed(
        Routes.guestUserFormScreen,
        arguments: {
          'category': category,
          'callBack': callback,
        },
      ),
    );
  }

  validateCallBack(category) {
    if (phoneController.text.isEmpty ||
        !(phoneController.text.replaceAll(RegExp('[^0-9]'), '').length == 10)) {
      phoneError.value = 'Please enter a valid phone number';
      phoneIsNotValid.value = true;
    }
    if (phoneController.text.isNotEmpty &&
        (phoneController.text.replaceAll(RegExp('[^0-9]'), '').length == 10)) {
      Map<String, dynamic> params = {
        "flowId": "5fbf74c6-0229-4f7e-a17e-5319f2d13291",
        "provider": "GlorifyMobileApp",
        "attributes": {
          'RoutingType': 'Callback',
          'RoutingKey': category.toString(),
          'CallbackUserName': controller.getUserFullName(),
          'CallbackNumber':
              phoneController.text.replaceAll(RegExp('[^0-9]'), ''),
          'MemberID': controller.userProfile.memberId,
          'FinalIntent': category.toString()
        },
        "direction": "INBOUND",
      };

      _pageStateController(PageState.SUCCESS);

      requestCallback(params);
    }
  }

  requestCallback(Map<String, dynamic> params) async {
    var response =
        await DataHelperImpl.instance.apiHelper.updateScheduleInfo(params);

    phoneController.clear();

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
    _pageStateController(PageState.DEFAULT);
  }
}
