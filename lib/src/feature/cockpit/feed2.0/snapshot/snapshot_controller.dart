import 'package:get/get.dart';
import 'package:glorifi/src/controllers/DeveloperOptionsController.dart';
import 'package:glorifi/src/controllers/account_flags_controller.dart';
import 'package:glorifi/src/controllers/base_event_listening_controller.dart';
import 'package:glorifi/src/controllers/credit_score_detail_screen_controller.dart';
import 'package:glorifi/src/controllers/home_value_controller.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/net_worth_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/total_debt_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';

class SnapshotController extends BaseEventListeningController {
  final AccountFlagsController accountFlagsController =
      Get.put(AccountFlagsController());

  final NetWorthController netWorthController = Get.put(NetWorthController());
  final CashOnHandController cashOnHandController =
      Get.put(CashOnHandController());
  final RetirementController retirementController =
      Get.put(RetirementController());
  final TotalDebtController debtController = Get.put(TotalDebtController());
  final HomeValueController homeValueController =
      Get.put(HomeValueController());
  final CreditScoreDetailScreenController creditScoreController =
      Get.put(CreditScoreDetailScreenController());

  int get currentNetWorth =>
      netWorthController.netWorthDetail?.value.totalAmount == null
          ? 0
          : netWorthController.netWorthDetail!.value.totalAmount.toInt();

  int get currentCashOnHand => cashOnHandController.totalAmount.value.toInt();

  int get currentRetirement => retirementController.totalFund.toInt();

  int get currentDebt => debtController.totalDebtDetail.value.totalDebt.toInt();
  PlaidController plaidController = Get.put(PlaidController());

  int get currentHomeValue =>
      homeValueController.homeValueDetail.value.value == null
          ? 0
          : homeValueController.homeValueDetail.value.value!.toInt();

  int get currentCreditScore =>
      creditScoreController.creditScoreModel.value.data?.creditScore == null
          ? 0
          : creditScoreController.creditScoreModel.value.data!.creditScore;

  ///only on tapped button, chose which chart so show
  Rx<int> tappedButtonIndex = Rx<int>(0);

  final RxBool isLoading = true.obs;
  final RxBool didLoad = false.obs;

  Future<void> pullRefresh() async {
    await loadData(showLoading: didLoad.value);
  }

  Future loadData({bool showLoading = true}) async {
    if (showLoading) {
      isLoading.value = true;
    }
    try {
      netWorthController.loadData();
      cashOnHandController.getCashOnHandDetail();
      retirementController.mapData();
      debtController.loadData();
      homeValueController.fetchAddressData();
      creditScoreController.getCreditScore();
      if (accountFlagsController.isLoading.isFalse) {
        await accountFlagsController.loadData(showLoading: false);
      }
      didLoad.value = true;
    } catch (e) {
      Log.error(e);
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onAccountsChanged(_) {
    loadData();
  }

  @override
  void onCreditScoreEnabled(_) {
    loadData();
  }

  void toNetWorth(int index) async {
    tappedButtonIndex.value = index;
    if (accountFlagsController.didLoad.isTrue) {
      (accountFlagsController.flags.value.hasPlaidLinkedAcct ||
              accountFlagsController.flags.value.hasAddr)
          ? Get.toNamed(Routes.netWorthDetailScreen)
          : await plaidController.openPlaid();
    }
  }

  void toCashOnHand(int index) async {
    tappedButtonIndex.value = index;
    if (accountFlagsController.didLoad.isTrue) {
      accountFlagsController.flags.value.hasPlaidLinkedAcct
          ? Get.toNamed(Routes.cashOnHand)
          : await plaidController.openPlaid();
    }
  }

  void toRetirementSavings(int index) async {
    tappedButtonIndex.value = index;
    if (accountFlagsController.didLoad.isTrue) {
      accountFlagsController.flags.value.hasPlaidLinkedAcct
          ? Get.toNamed(Routes.savingsRetirementScreen)
          : await plaidController.openPlaid();
    }
  }

  void toCreditScore(int index) async {
    tappedButtonIndex.value = index;
    if (accountFlagsController.didLoad.isTrue) {
      accountFlagsController.flags.value.hasCreditPermission ||
              Get.find<DeveloperOptionsController>()
                  .isMockedCreditScoreEnabled
                  .isTrue
          ? Get.toNamed(Routes.creditScoreDetailScreen)
          : Get.toNamed(Routes.enableCreditScoreStep1Name);
    }
  }

  void toTotalDebt(int index) async {
    tappedButtonIndex.value = index;
    if (accountFlagsController.didLoad.isTrue) {
      accountFlagsController.flags.value.hasPlaidDebt
          ? Get.toNamed(Routes.totalDebtDetailScreen)
          : await plaidController.openPlaid();
    }
  }

  void toHomeValue(int index) async {
    tappedButtonIndex.value = index;
    if (accountFlagsController.didLoad.isTrue) {
      accountFlagsController.flags.value.hasAddr ||
              (homeValueController.homeValueDetail.value.value != 0 &&
                  homeValueController.homeValueDetail.value.value != null)
          ? Get.toNamed(Routes.homeValueDetailsScreen)
          : Get.toNamed(Routes.selectAddressScreen);
    }
  }

  void toEditProfile() {
    Get.toNamed(Routes.editProfileLanding);
  }

  void addAddress() {
    Get.toNamed(
      Routes.selectAddressScreen,
    );
  }

  void enableCreditScore() {
    Get.toNamed(
      Routes.enableCreditScoreStep1Name,
    );
  }
}
