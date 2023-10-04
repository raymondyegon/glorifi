import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_service.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/order_card/oao_order_debt_card_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_service.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_account_detail_model.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_manage_pin_response.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_transaction.dart';

class EBSController extends GetxController {
  final _service = Get.find<EBSService>();
  final String accountId;
  final Rx<EBSAccountDetailModel> _accountDetails =
      EBSAccountDetailModel.empty().obs;

  final loadingDetails = false.obs;
  final errorFetchingDetails = false.obs;

  final loadingTransactions = false.obs;
  final errorFetchingTransactions = false.obs;

  // For simplicity of observable, keep card status on the controller
  final cardStatus = ''.obs;

  // Used to show a spinner when either activation, suspending, or unsuspending a card in Settings
  final cardTransitionLoading = false.obs;
  final cardTransitionErrorString = ''.obs;

  //pagination for all transactions
  final loadingAllTransactions = false.obs;
  final loadingMoreTransactions = false.obs;
  int _paginationOffset = 0;
  int _limit = 20;

  // Pin management
  final loadingPinStuff = false.obs;
  final managePinResponse =
      EBSManagePinResponse(applicationId: '', oneTimeToken: '', userToken: '')
          .obs;

  EBSAccountDetailModel get details => _accountDetails.value;

  // loading
  final Rx<EBSTransactions> _transactions =
      Rx<EBSTransactions>(EBSTransactions.empty());

  EBSTransactions get transactions => _transactions.value;

  final Rx<EBSTransactions> _allTransactions =
      Rx<EBSTransactions>(EBSTransactions.empty());

  EBSTransactions get allTransactions => _allTransactions.value;

  EBSController({required this.accountId});

  String get accountDetailTitle => details.accountNumber != ''
      ? '${details.accountType} ....${details.accountNumber.substring(details.accountNumber.length - 4)}'
      : '';

  RxBool _obscuredDetails = true.obs;

  bool get obscuredDetails => _obscuredDetails.value;

  Rx<PartialAddress> userAddress = PartialAddress().obs;

  @override
  void onInit() {
    _fetchDetails();
    _fetchInitialTransactions();
    _fetchAddress();
    super.onInit();
  }

  _fetchDetails() async {
    loadingDetails.value = true;
    errorFetchingDetails.value = false;
    try {
      final details = await _service.getAccountDetails(accountId);
      if (details != null) {
        errorFetchingDetails.value = false;
        _accountDetails.value = details;
        cardStatus.value = details.cardStatus;
      } else {
        errorFetchingDetails.value = true;
      }
    } catch (e) {
      errorFetchingDetails.value = true;
    }
    loadingDetails.value = false;
  }

  retryDetails() async {
    _fetchDetails();
  }

  _fetchInitialTransactions() async {
    loadingTransactions.value = true;
    try {
      _transactions.value = await _service.getTransactions(accountId, 0, 10);
    } catch (e) {
      // Error fetching transactions. Retry button
      Log.info(e);
    }
    loadingTransactions.value = false;
  }

  _fetchAddress() async {
    // TODO: This is probably better in a WireInstructions controller since not every member is going to navigate to that screen.
    userAddress.value = await _service.fetchUserAddress(mailingAddress: false);
  }

  initAllTransactionsList() async {
    _paginationOffset = 0;
    loadingAllTransactions.value = true;

    try {
      _allTransactions.value = await _service.getTransactions(accountId, 0, 20);
      _paginationOffset = _allTransactions.value.returned;
    } catch (e) {
      // Error fetching transactions. Retry button
      Log.info(e);
    }
    loadingAllTransactions.value = false;
  }

  fetchMoreTransactions() async {
    if (_allTransactions.value.items.length < _allTransactions.value.total) {
      loadingMoreTransactions.value = true;

      try {
        final EBSTransactions _tempTransactions =
            await _service.getTransactions(accountId, _paginationOffset, 20);
        _allTransactions.value.items.addAll(_tempTransactions.items);
        _allTransactions.value.returned = _tempTransactions.returned;
        _paginationOffset += _tempTransactions.returned;
      } catch (e) {
        // Error fetching transactions. Retry button
        Log.info(e);
      }
      loadingMoreTransactions.value = false;
    }
  }

  lockCard() async {
    cardTransitionErrorString.value = '';
    cardTransitionLoading.value = true;
    final success = await _service.suspendCard(details.cardId);
    // Update model locally instead of fetching fresh copy
    if (success) {
      cardStatus.value = "SUSPENDED";
    } else {
      cardTransitionErrorString.value =
          'We were unable to suspend your card. Please try again later.';
    }
    cardTransitionLoading.value = false;
  }

  unlockCard() async {
    cardTransitionErrorString.value = '';
    cardTransitionLoading.value = true;
    final success = await _service.unsuspendCard(details.cardId);
    // Update model locally instead of fetching fresh copy
    if (success) {
      cardStatus.value = "ACTIVE";
    } else {
      cardTransitionErrorString.value =
          'We were unable to unsuspend your card. Please try again later.';
    }
    cardTransitionLoading.value = false;
  }

  activateCard() async {
    cardTransitionErrorString.value = '';
    cardTransitionLoading.value = true;
    final success = await _service.activateCard(details.cardId);
    // Update model locally instead of fetching fresh copy
    if (success) {
      cardStatus.value = "ACTIVE";
    } else {
      cardTransitionErrorString.value =
          'We were unable to activate your card. Please try again later.';
    }
    cardTransitionLoading.value = false;
  }

  onOrderDebitCard() async {
    cardTransitionLoading.value = true;
    Get.put(OAOService());
    Get.put(OAOController(fromEBS: true));
    OAOController oaoController = Get.find();
    await oaoController.fetchDebitCardOptions();
    oaoController.application.accountId = details.accountId;

    // Fetch the existing user for their address
    // TODO: Since we are fetching the address for wire instruction, we don't need to fetch this again.
    // FIXME: This is going to default to the mailing address. Not every user puts in a separate mailing address
    final address = await _service.fetchUserAddress();
    oaoController.application.address = address;
    cardTransitionLoading.value = false;
    return Get.to(() => OAODebitCardScreen());
  }

  fetchPinCredentials() async {
    loadingPinStuff.value = true;
    try {
      managePinResponse.value =
          await _service.getChangePinCredentials(details.cardId);
    } catch (e) {
      // TODO: Show an error? Get.back since the webview won't do anything without this data?
      Get.back();
    }
    loadingPinStuff.value = false;
  }

  void toggleAccountDetailsVisibility() {
    _obscuredDetails.toggle();
  }
}
