import 'dart:developer';

import 'package:get/get.dart';
import 'package:glorifi/src/controllers/base_event_listening_controller.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/banking/model/connected_account_model.dart';
import 'package:glorifi/src/feature/banking/model/glorifi_accounts_model.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/eligible_accounts_model.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_dashboard_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/my_bank_service.dart';

import '../../../utils/support/support_navigation_helper.dart';
import '../model/banking_banner_model.dart';
import '../model/glorifi_accounts_model.dart';

class MyBankController extends BaseEventListeningController {
  RxList<BankingBannerDataModel> bannerData = RxList<BankingBannerDataModel>();
  Rx<CCDashboardModel> creditCardAccount = CCDashboardModel.empty().obs;
  RxList<GloriFiAccountData> connectedGloriFiAccountData =
      RxList<GloriFiAccountData>();
  RxList<LinkedAccounts> externalFundingAccounts = <LinkedAccounts>[].obs;
  late PlaidController plaidController;
  RxBool isMockEnabled = false.obs;

  final fetchingGlorifiAccounts = false.obs;
  final errorFetchingGlorifiAccounts = false.obs;

  get isBannerListEmpty {
    return bannerData.isEmpty;
  }

  get haveGloriFiAccounts {
    return connectedGloriFiAccountData.isNotEmpty;
  }

  @override
  void onInit() async {
    plaidController = Get.put(PlaidController());
    super.onInit();
    // getAccountCardsBanner();
    getCreditCardAccount();
    getConnectedAccounts();
    getConnectedGloriFiAccounts();
  }

  Future<void> pullRefresh() async {
    await getCreditCardAccount();

    await getConnectedGloriFiAccounts();
    await getConnectedAccounts();
    
  }

  Future<void> getAccountCardsBanner() async {
    BankingBannerModel response =
        await MyBankService().getBankingBanner() as BankingBannerModel;
    bannerData.addAll(response.data);
  }

  Future<void> getConnectedAccounts() async {
    try {
      externalFundingAccounts.value =
          await MyBankService().getExternalFundingAccounts();
    } catch (e) {
      Log.error(e);
    }
  }

  Future<void> getCreditCardAccount() async {
    creditCardAccount.value = CCDashboardModel.empty();
    CCDashboardModel? cc = await MyBankService().getCreditCardAccount(isMockEnabled.value);

    if (cc != null) {
      creditCardAccount.value = cc;
    }
  }

  Future<void> getConnectedGloriFiAccounts() async {
    fetchingGlorifiAccounts.value = true;
    errorFetchingGlorifiAccounts.value = false;
    try {
      GlorifiAccountResponse response = await MyBankService()
          .getConnectedGloriFiAccounts() as GlorifiAccountResponse;
      connectedGloriFiAccountData.clear();
      connectedGloriFiAccountData.addAll(response.data.accounts);
    } catch (e) {
      errorFetchingGlorifiAccounts.value = true;
      Log.error(e.toString());
    }
    fetchingGlorifiAccounts.value = false;
  }

  @override
  onAccountsChanged(_) {
    getConnectedAccounts();
  }

  Future<void> navigateToFAQ() async {
    String category = 'Banking';
    SupportNavigationHelper.navigateToList(category);
  }

  Future<void> navigateToWelcomeToGlorifiScreen() async {
    Get.toNamed(Routes.welcomeToGlorifi, arguments: ["Banking"]);
  }

  Future<void> navigateToBlend() async {
    Get.offNamed(Routes.connectBlendSso);
  }

  Future<void> navigateToPlaid() async {
    await plaidController.openPlaid();
  }

  Future<void> navigateToBackBase() async {
    Get.toNamed(Routes.openBankAccount);
  }
}

enum AccountType { NONE, CHECKING, SAVINGS, CD }
