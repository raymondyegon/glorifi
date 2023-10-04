import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/feature/bundles/controller/bundle_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/model/bank_account_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/model/open_account.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/model/explore_data_model.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/feature/insurance/controller/insurance_controller.dart';
import 'package:glorifi/src/feature/mortgage/controllers/mortgage_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

import '../../../../credit_card/credit_card_coming_soon.dart';
import '../../../../credit_card/model/notify_data.dart';
import '../../../../mortgage/widgets/email_notify_success.dart';

class AccountsController extends BaseController {
  final mortgageController = Get.put(MortgageController());
  final insuranceController = Get.put(InsuranceController());
  final myBankController = Get.put(MyBankController());
  final bundleController = Get.put(BundleController());

  final _bankAccountListController = RxList<BankAccountModel>();
  final _dataHelper = DataHelperImpl.instance;
  final _comingSoonListController = RxList<Contents>();
  final _openAccountList = RxList<OpenAccount>();

  final haveGloriFiAccounts = false.obs;

  List<BankAccountModel> get bankAccountList =>
      _bankAccountListController.toList();

  List<Contents> get comingSoonList => _comingSoonListController.toList();

  List<OpenAccount> get openAccountList => _openAccountList.toList();

  var isLoading = "".obs;

  final comingSoonIndex = 0.obs;
  final availableProductsIndex = 0.obs;

  @override
  void onInit() async {
    bundleController.fetchBundles();
    _prepareBankAccountList();
    _prepareComingSoonList();
    _openAccount();
    super.onInit();
  }

  Future<void> pullRefresh() async {
    await myBankController.pullRefresh();
    await mortgageController.pullRefresh();
    await insuranceController.pullRefresh();
    bundleController.bundleList.clear();
    await bundleController.fetchBundles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<ExploreData>> getData() async {
    final response = await _dataHelper.apiHelper.getExploreData();
    return response.fold((l) {
      throw l.errorMessage;
    }, (r) {
      return r;
    });
  }

  Future<Map<String, dynamic>?> notifyEmailStatus(
      String product, String stateName) async {
    isLoading.value = product; // Start loading tile
    final response =
        await _dataHelper.apiHelper.notifyEmailStatus(product, stateName);
    isLoading.value = ""; // Finish loading tile
    late NotifyData br;
    response.fold((l) => null, (r) => {br = NotifyData.fromJson(r)});
    if (br.data?.Notified != null) {
      if (br.data?.Notified == true) {
        Get.to(
          EmailNotifySuccess(
            onTap: Get.back,
            showLegalName: false,
          ),
        );
      } else {
        product == "Investments"
            ? Get.toNamed(Routes.brokerageMainPage)
            : Get.to(
                CreditCardComingSoon(
                  isAlreadyNotified: false,
                ),
              );
      }
    }
  }

  void _prepareBankAccountList() {
    List<BankAccountModel> bankAccountList = [
      BankAccountModel(
          accountName: 'Checking', muskNumber: '*1234', balance: '\$3,500.00'),
      BankAccountModel(
          accountName: 'Savings', muskNumber: '*1234', balance: '\$97,428.67'),
      BankAccountModel(
          accountName: 'CD', muskNumber: '*1234', balance: '\$30,428.67')
    ];
    _bankAccountListController(bankAccountList);
  }

  void _prepareComingSoonList() {
    List<Contents> comingSoonList = [
      Contents(
          title: "Credit Card",
          asset: GlorifiAssets.creditCard,
          showSubtitle: false,
          route: Routes.creditCardComingSoonScreen,
          type: ""),
      Contents(
          title: "Investments",
          asset: GlorifiAssets.trendingUp,
          showSubtitle: false,
          route: Routes.brokerageMainPage,
          type: ""),
      if (FeatureFlagManager.mortgageEnabled == false)
        Contents(
            title: 'Mortgage',
            asset: GlorifiAssets.home,
            showSubtitle: false,
            type: '',
            route: null),
      if (FeatureFlagManager.insuranceEnabled == false)
        Contents(
            title: 'Insurance',
            asset: GlorifiAssets.shield,
            showSubtitle: false,
            type: '',
            route: null)
    ];
    _comingSoonListController(comingSoonList);
  }

  void _openAccount() {
    List<OpenAccount> openAccountList = [
      OpenAccount(accountType: "Checking"),
      OpenAccount(accountType: "Savings"),
      OpenAccount(accountType: "CD"),
    ];
    _openAccountList(openAccountList);
  }

  Future<void> navigateToTransfer() async {
    Get.toNamed(
      Routes.ebsTransfer,
      // arguments: {
      //   "accountType": AccountType.SAVINGS,
      //   "connected": true,
      //   "plaidAccount": false,
      // },
    );
  }

  Future<void> navigateToDeposit() async {
    if (await DataHelperImpl.instance.cacheHelper
        .getUserTermsAcceptanceStatus()) {
      Get.toNamed(Routes.mobileDepositTo);
    } else {
      navigate(route: Routes.checkDepositConsent);
    }
  }

  Future<void> navigateToATMLocator() async {
    navigate(route: Routes.findAtms);
  }

  void navigate({required final String route}) {
    Get.toNamed(route);
  }

  Future<void> navigateToBackBase({required AccountType accountType}) async {
    Get.toNamed(Routes.openBankAccount);
  }
}
