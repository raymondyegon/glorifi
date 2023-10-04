import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card/credit_card_coming_soon.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_applications_data.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_data.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_response.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/coming_soon_service.dart';
import 'package:glorifi/src/services/credit_card_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';

import '../../../controllers/plaid_controller.dart';
import '../../../core/data_helper.dart';
import '../../../utils/text_constants.dart';
import '../../mortgage/widgets/email_notify_success.dart';
import '../model/notify_data.dart';

class CreditCardController extends BaseController {
  final creditCardDetails = DetailData(
    progress: 0,
    amount: "",
    availableAmount: "",
    cardType: "",
    lastFourCardNumber: 0,
    minimumAmountDue: "",
    paymentDueDate: "",
  ).obs;
  RxList<CreditCardData> creditCardData = RxList<CreditCardData>();
  RxList<ExternalCreditCardData> externalCreditCardData =
      RxList<ExternalCreditCardData>();
  RxList<ApplicationsData> activeCreditCardData = RxList<ApplicationsData>();
  late PlaidController plaidController;
  final _dataHelper = DataHelperImpl.instance;

  var numPages = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  var currentPage = 0.obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    plaidController = Get.put(PlaidController());
    super.onInit();
    //getCreditCards();
    //getCreditCardApplications();
  }

  Future<void> getCreditCardDetails() async {
    CreditCardData response =
        await CreditCardService().getCreditCardDetailData() as CreditCardData;
    creditCardDetails.value = response.data as DetailData;
  }

  Future<void> getCreditCards() async {
    CreditCardResponse response =
        await CreditCardService().getCreditCardData() as CreditCardResponse;
    externalCreditCardData.addAll(response.data);
  }

  Future<void> getCreditCardApplications() async {
    CreditCardApplicationsData response = await CreditCardService()
        .getCreditCardApplicationsData() as CreditCardApplicationsData;
    activeCreditCardData.addAll(response.data
        .where((element) => element.status == "Application in Progress"));
  }

  Future<void> sendNotify(String product, String state) async {
    await ComingSoonService().notifyEmail(product, state)
        as Map<String, dynamic>;
    Get.off(
      EmailNotifySuccess(
        onTap: () {
          Get.offNamedUntil(Routes.cockpit, (route) => true);
        },
        showLegalName: false,
      ),
    );
  }

  Future<Map<String, dynamic>?> notifyEmailStatus(String product, String stateName) async {
    try {
      isLoading(true);
      final response = await _dataHelper.apiHelper.notifyEmailStatus(product, stateName);
      late NotifyData br;
      response.fold((l) => null, (r) => {br = NotifyData.fromJson(r)});
      if (br.data?.Notified != null) {
        if (br.data?.Notified == true) {
          if(product == TextConstants.mortgage){
            Get.off(
              EmailNotifySuccess(
                onTap: Get.back,
                showLegalName: false,
              ),
            );
          } else {
            Get.to(CreditCardComingSoon(isAlreadyNotified: true,),);
          }
        } else {
          sendNotify(product, stateName);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  gotoApplicationPage(CARD_TYPE cardType) {
    var data = {"card_type": cardType};
    Get.toNamed(Routes.creditCardFAQ, arguments: data);
  }

  Future<void> navigateToWelcomeToGlorifiScreen() async {
    Get.toNamed(Routes.welcomeToGlorifi, arguments: {"screen": "Credit Card"});
  }

  Future<void> navigateToBlend() async {
    Get.toNamed(Routes.connectBlendSso);
  }

  Future<void> navigateToPlaid() async {
    await plaidController.openPlaid();
  }
}

enum CARD_TYPE { BRASS_CARD, REWARDS_CARD }
