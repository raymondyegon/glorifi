import 'package:get/get.dart';
import 'package:glorifi/src/controllers/member_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/support/support_widgets/chat_webview.dart';
import 'package:glorifi/src/model/support/schedule_hours_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:glorifi/src/utils/login_status/login_status.dart';

import '../../feature/feature_flag/feature_flag_manager.dart';

class ContactSupportController extends BaseController {
  final dataImpl = DataHelperImpl.instance;
  ProfileController? profileController;
  MemberController? memberController;

  RxList list = [].obs;

  Rx<ScheduleHoursModel> scheduleHours = ScheduleHoursModel().obs;

  final Rx<PageState> _pageStateController = Rx(PageState.SUCCESS);

  get pageState => _pageStateController.value;

  RxString email = ''.obs;
  RxString selectedCategory = ''.obs;

  late FAQCategoriesController faqCategoriesController;

  @override
  void onInit() {
    faqCategoriesController = Get.find<FAQCategoriesController>();

    if (faqCategoriesController.list.isEmpty) {
      getFaqCategories();
    }

    CheckLoginStatus.checkLoginStatus(alreadyLoggedIn, notLoggedIn);
    super.onInit();
  }

  getFaqCategories() async {
    RxList orderedList = [
      if (FeatureFlagManager.BankingSupportEnabled) 'Banking',
      if (FeatureFlagManager.InsuranceSupportEnabled) 'Insurance',
      if (FeatureFlagManager.MortgageSupportEnabled) 'Mortgage',
      if (FeatureFlagManager.GeneralQuestionsSupportEnabled) 'General Questions'
    ].obs;

    Map<String, dynamic> faqCategories =
        await dataImpl.cacheHelper.getFAQCategories();

    faqCategories.forEach((key, value) {
      list.add(key);
    });

    orderedList.forEach(
      (element) {
        if (list.contains(element.toString().toLowerCase())) {
          list.remove(element.toString().toLowerCase());
        }
      },
    );

    if (list.isNotEmpty) {
      list.clear();
    }

    list.insertAll(0, orderedList);
    faqCategoriesController.list
        .addAllIf(faqCategoriesController.list.isEmpty, list);
    update();
  }

  getScheduleInformation(category) async {
    var response = await DataHelperImpl.instance.apiHelper
        .getScheduleInformationResponse(category);

    response.fold(
      (l) {
        if (faqCategoriesController.isBottomSheet) {
          faqCategoriesController.navigationStack
              .insert(0, ContactSupportErrorScreen);
          faqCategoriesController.update();
        } else {
          Get.toNamed(Routes.contactSupportErrorScreen);
        }
      },
      (r) {
        scheduleHours.value.isOpenCallback = r['data']['isOpenCallback'];
        scheduleHours.value.isOpenChat = r['data']['isOpenChat'];
        scheduleHours.value.isOpenEmail = r['data']['IsOpenEmail'];
        scheduleHours.value.scheduleFormatted = r['data']['ScheduleFormatted'];
      },
    );
    _pageStateController(PageState.SUCCESS);
  }

  callConversationEmailApi(category) async {
    Map<String, dynamic> params = {
      "flowId": "5fbf74c6-0229-4f7e-a17e-5319f2d13291",
      "provider": "GlorifyMobileApp",
      "attributes": {
        'RoutingType': 'ScheduleSync',
        'RoutingKey': category.toString(),
      },
      "direction": "INBOUND",
    };

    _pageStateController(PageState.LOADING);
    var response = await dataImpl.apiHelper.updateScheduleInfo(params);

    response.fold((l) => Get.toNamed(Routes.contactSupportErrorScreen), (r) {
      if (r['success']) {
        getScheduleInformation(category);
      }
    });
  }

  navigateToContactSupport(category) {
    if (faqCategoriesController.isBottomSheet) {
      faqCategoriesController.selectedCategoryTitle = category;
      faqCategoriesController.selectedCategoryKey = category;

      faqCategoriesController.navigationStack.insert(0, ContactSupportScreen);
      faqCategoriesController.update();
    } else {
      Get.toNamed(Routes.contactSupportScreen, arguments: {
        'category': category,
      }, parameters: {
        'category': category,
        'scheduleFormatted': scheduleHours.value.scheduleFormatted.toString(),
        'isOpenChat': scheduleHours.value.isOpenChat.toString(),
        'isOpenCallback': scheduleHours.value.isOpenCallback.toString(),
      });
    }
  }

  navigateToEmailSupport(category) {
    CheckLoginStatus.checkLoginStatus(
      () {
        if (faqCategoriesController.isBottomSheet) {
          faqCategoriesController.selectedSupportCategoryTitle = category;
          faqCategoriesController.name = profileController?.getUserFullName();
          faqCategoriesController.email = profileController?.userProfile.email;
          faqCategoriesController.phone = profileController
              ?.userProfile.phoneNumber
              .replaceAll(RegExp('[^0-9]'), '');
          faqCategoriesController.memberID =
              profileController?.userProfile.memberId;

          faqCategoriesController.navigationStack.insert(0, MessageUsScreen);
          faqCategoriesController.update();
        } else {
          Get.toNamed(
            Routes.messageUsScreen,
            arguments: {
              'category': category,
              'name': profileController?.getUserFullName(),
              'email': profileController?.userProfile.email,
              'phone': profileController?.userProfile.phoneNumber
                  .replaceAll(RegExp('[^0-9]'), ''),
              'memberID': profileController?.userProfile.memberId,
            },
          );
        }
      },
      () {
        if (faqCategoriesController.isBottomSheet) {
          faqCategoriesController.selectedSupportCategoryTitle = category;
          faqCategoriesController.selectedSupportMethod = 'email';

          faqCategoriesController.navigationStack
              .insert(0, GuestUserFormScreen);
          faqCategoriesController.update();
        } else {
          Get.toNamed(
            Routes.guestUserFormScreen,
            arguments: {'category': category, 'method': 'email'},
            parameters: {'category': category, 'method': 'email'},
          );
        }
      },
    );
  }

  navigateToCallBackScreen(category) {
    //todo bottomsheet flow
    CheckLoginStatus.checkLoginStatus(() async {
      if (faqCategoriesController.isBottomSheet) {
        faqCategoriesController.selectedSupportCategoryTitle = category;
        //todo should we remove the spaces ?
        faqCategoriesController.phone =
            profileController?.userProfile.phoneNumber;

        faqCategoriesController.navigationStack
            .insert(0, RequestCallbackScreen);
        faqCategoriesController.update();
      } else {
        Get.toNamed(
          Routes.requestCallBack,
          arguments: {
            'category': category,
            'phone': profileController?.userProfile.phoneNumber,
          },
        );
      }
    }, () {
      if (faqCategoriesController.isBottomSheet) {
        faqCategoriesController.selectedSupportCategoryTitle = category;
        faqCategoriesController.selectedSupportMethod = 'callback';

        faqCategoriesController.navigationStack.insert(0, GuestUserFormScreen);
        faqCategoriesController.update();
      } else {
        Get.toNamed(
          Routes.guestUserFormScreen,
          arguments: {
            'category': category,
            'method': 'callback',
          },
          parameters: {
            'category': category,
            'method': 'callback',
          },
        );
      }
    });
  }

  navigateToChatScreen(category) {
    //todo bottomsheet flow
    category =
        category.toLowerCase().contains('general') ? 'general' : category;
    CheckLoginStatus.checkLoginStatus(
        //authenticated case
        () async {
      if (faqCategoriesController.isBottomSheet) {
        faqCategoriesController.routingKey = category;
        faqCategoriesController.finalIntent = category;
        faqCategoriesController.name = profileController?.getUserFullName();
        faqCategoriesController.email = profileController?.userProfile.email;
        faqCategoriesController.phone = profileController
            ?.userProfile.phoneNumber
            .replaceAll(RegExp('[^0-9]'), '');
        faqCategoriesController.memberID =
            profileController?.userProfile.memberId;

        faqCategoriesController.navigationStack.insert(0, ChatWebViewScreen);
        faqCategoriesController.update();
      } else {
        Get.to(ChatWebView(), arguments: {
          'RoutingKey': category,
          'MemberEmail': memberController?.member,
          'MemberName': profileController?.getUserFullName(),
          'MemberPhone': profileController?.userProfile.phoneNumber
              .replaceAll(RegExp('[^0-9]'), ''),
          'MemberID': profileController?.userProfile.memberId,
          'FinalIntent': category
        });
      }
    },
        //unauthenticated case
        () {
      if (faqCategoriesController.isBottomSheet) {
        faqCategoriesController.selectedSupportCategoryTitle = category;
        faqCategoriesController.selectedSupportMethod = 'chat';

        faqCategoriesController.navigationStack.insert(0, GuestUserFormScreen);
        faqCategoriesController.update();
      } else {
        Get.toNamed(
          Routes.guestUserFormScreen,
          arguments: {
            'category': category,
            'method': 'chat',
          },
          parameters: {
            'category': category,
            'method': 'chat',
          },
        );
      }
    });
  }

  notLoggedIn() {}

  alreadyLoggedIn() {
    profileController = Get.find<ProfileController>();
    memberController = Get.find<MemberController>();
  }
}
