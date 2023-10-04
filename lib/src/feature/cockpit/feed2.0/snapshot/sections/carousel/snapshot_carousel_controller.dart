import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/account_flags_controller.dart';
import 'package:glorifi/src/controllers/base_event_listening_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/link_more_accounts_card/last_linked_account_controller.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';

const ACTION_CARD_KEY_LINK_ACCOUNTS = 'linkAccountsCard';
const ACTION_CARD_KEY_CREDIT_SCORE = 'creditScoreCard';
const ACTION_CARD_KEY_ADD_ADDRESS = 'addAddressCard';
const ACTION_CARD_KEY_LINK_MORE_ACCOUNTS = 'linkMoreAccountsCard';
const ACTION_CARD_KEY_COMPLETE_PROFILE = 'completeProfileCard';

enum CarouselCardType {
  LinkAccounts,
  LinkMoreAccounts,
  EnableCreditScore,
  CreditScoreDetail,
  Address,
  CompleteProfile,
  HomeValue,
  NetWorth,
  Retirement,
  CashOnHand,
  TotalDebt,
}

class SnapshotCarouselController extends BaseEventListeningController {
  final AccountFlagsController accountFlagsController =
      Get.put(AccountFlagsController());

  final ProfileController _profileController = Get.put(ProfileController());

  final CarouselController carouselController = CarouselController();

  var current = 0.obs;

  RxList<CarouselCardType> cards = RxList.empty();

  RxBool dismissedCardsLoaded = false.obs;

  bool enableCreditScoreCardWasDismissed = false;
  bool addAddressCardWasDismissed = false;
  bool linkAccountsCardWasDismissed = false;
  bool linkMoreAccountsCardWasDismissed = false;
  bool completeProfileCardWasDismissed = false;

  bool get isLoading =>
      dismissedCardsLoaded.isFalse ||
      accountFlagsController.isLoading.isTrue &&
          accountFlagsController.didLoad.isFalse;

  @override
  void onInit() {
    checkForDismissedCards();
    super.onInit();
  }

  pullToRefresh() async {
    await accountFlagsController.loadData(showLoading: true);
    await setCards();
    if (cards.contains(CarouselCardType.LinkMoreAccounts)) {
      final lastLinkedAccountController =
          Get.find<LastLinkedAccountController>();
      lastLinkedAccountController.getLastAddedAccountInfo();
    }
  }

  @override
  void onAccountsChanged(_) {
    accountFlagsController.loadData().then((value) => setCards());
  }

  @override
  void onCreditScoreEnabled(_) {
    accountFlagsController.loadData().then((value) => setCards());
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    current.value = index;
    update();
  }

  Future checkForDismissedCards() async {
    enableCreditScoreCardWasDismissed = await DataHelperImpl
            .instance.cacheHelper
            .wasActionCardDismissed(ACTION_CARD_KEY_CREDIT_SCORE) ==
        true;
    addAddressCardWasDismissed = await DataHelperImpl.instance.cacheHelper
            .wasActionCardDismissed(ACTION_CARD_KEY_ADD_ADDRESS) ==
        true;
    linkMoreAccountsCardWasDismissed = await DataHelperImpl.instance.cacheHelper
            .wasActionCardDismissed(ACTION_CARD_KEY_LINK_MORE_ACCOUNTS) ==
        true;
    completeProfileCardWasDismissed = await DataHelperImpl.instance.cacheHelper
            .wasActionCardDismissed(ACTION_CARD_KEY_COMPLETE_PROFILE) ==
        true;
    dismissedCardsLoaded.value = true;
  }

  Future setCards() async {
    /// LinkAccounts
    if (!accountFlagsController.flags.value.hasPlaidLinkedAcct &&
        !linkAccountsCardWasDismissed) {
      if (!cards.contains(CarouselCardType.LinkAccounts)) {
        cards.add(CarouselCardType.LinkAccounts);
      }
    } else {
      cards.removeWhere((element) => element == CarouselCardType.LinkAccounts);
    }

    /// LinkMoreAccounts
    if (accountFlagsController.flags.value.hasPlaidLinkedAcct &&
        !linkMoreAccountsCardWasDismissed) {
      if (!cards.contains(CarouselCardType.LinkMoreAccounts)) {
        cards.insert(0, CarouselCardType.LinkMoreAccounts);
      }
    } else {
      cards.removeWhere(
          (element) => element == CarouselCardType.LinkMoreAccounts);
    }

    /// EnableCreditScore
    if (!accountFlagsController.flags.value.hasCreditPermission &&
        !enableCreditScoreCardWasDismissed &&
        FeatureFlagManager.snapshotCreditScoreEnabled) {
      if (!cards.contains(CarouselCardType.EnableCreditScore)) {
        cards.add(CarouselCardType.EnableCreditScore);
      }
    } else {
      cards.removeWhere(
          (element) => element == CarouselCardType.EnableCreditScore);
    }

    /// Address
    if (!accountFlagsController.flags.value.hasAddr &&
        !addAddressCardWasDismissed &&
        FeatureFlagManager.snapshotHomeValueEnabled) {
      if (!cards.contains(CarouselCardType.Address)) {
        cards.add(CarouselCardType.Address);
      }
    } else {
      cards.removeWhere((element) => element == CarouselCardType.Address);
    }

    /// CompleteProfile
    if (!_profileController.profileCompleted &&
        !completeProfileCardWasDismissed) {
      if (!cards.contains(CarouselCardType.CompleteProfile)) {
        cards.add(CarouselCardType.CompleteProfile);
      }
    } else {
      cards.removeWhere(
          (element) => element == CarouselCardType.CompleteProfile);
    }

    /// CreditScoreDetail
    if (accountFlagsController.flags.value.hasCreditPermission) {
      if (!cards.contains(CarouselCardType.CreditScoreDetail)) {
        cards.add(CarouselCardType.CreditScoreDetail);
      }
    } else {
      cards.removeWhere(
          (element) => element == CarouselCardType.CreditScoreDetail);
    }

    // Total Debt
    if (accountFlagsController.flags.value.hasPlaidDebt) {
      if (!cards.contains(CarouselCardType.TotalDebt)) {
        cards.add(CarouselCardType.TotalDebt);
      }
    }

    // Retirement
    if (accountFlagsController.flags.value.hasPlaidRetirement) {
      if (!cards.contains(CarouselCardType.Retirement)) {
        cards.add(CarouselCardType.Retirement);
      }
    }

    // Net Worth
    if (accountFlagsController.flags.value.hasPlaidLinkedAcct) {
      if (!cards.contains(CarouselCardType.NetWorth)) {
        cards.add(CarouselCardType.NetWorth);
      }
    }

    // Cash on Hand
    if (accountFlagsController.flags.value.hasPlaidLinkedAcct) {
      if (!cards.contains(CarouselCardType.CashOnHand)) {
        cards.add(CarouselCardType.CashOnHand);
      }
    }
  }

  void dismissCard(String cardKey) {
    switch (cardKey) {
      case ACTION_CARD_KEY_LINK_ACCOUNTS:
        cards
            .removeWhere((element) => element == CarouselCardType.LinkAccounts);
        linkAccountsCardWasDismissed = true;
        break;
      case ACTION_CARD_KEY_CREDIT_SCORE:
        cards.removeWhere(
            (element) => element == CarouselCardType.EnableCreditScore);
        enableCreditScoreCardWasDismissed = true;
        break;
      case ACTION_CARD_KEY_ADD_ADDRESS:
        cards.removeWhere((element) => element == CarouselCardType.Address);
        addAddressCardWasDismissed = true;
        break;
      case ACTION_CARD_KEY_LINK_MORE_ACCOUNTS:
        cards.removeWhere(
            (element) => element == CarouselCardType.LinkMoreAccounts);
        linkMoreAccountsCardWasDismissed = true;
        break;
      case ACTION_CARD_KEY_COMPLETE_PROFILE:
        cards.removeWhere(
            (element) => element == CarouselCardType.CompleteProfile);
        completeProfileCardWasDismissed = true;
        break;
    }
    DataHelperImpl.instance.cacheHelper.dismissActionCard(cardKey);
    setCards();
  }
}
