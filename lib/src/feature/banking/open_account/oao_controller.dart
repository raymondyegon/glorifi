
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_debit_card.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_deposit_account.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_disclosure.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_funding_accounts_model.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_workflow_options.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_service.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_exit_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_further_review.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/fund/oao_deposit_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/fund/oao_fund_your_account_plaid_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/fund/oao_funding_accounts_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_citizen_screen1.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_personal_information_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_review_application_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_error_screen.dart';
import 'package:glorifi/src/model/address_data.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:glorifi/src/routes/app_pages.dart';

class OAOController extends GetxController {
  final _service = Get.find<OAOService>();
  final checkingProducts = <OAODepositAccount>[].obs;
  final savingsProducts = <OAODepositAccount>[].obs;
  final cdProducts = <OAODepositAccount>[].obs;
  Rxn<OAOFundingAccountsModel> fundingAccountsData = Rxn<OAOFundingAccountsModel>();

  final Rxn<FundingLinkedAccountModel> selectedFundingAccount = Rxn<FundingLinkedAccountModel>();
  final RxnBool selectedFundingAccountIsGlorifi = RxnBool();
  final productDisclosures = <OAODisclosure>[].obs;

  OAOMemberApplication get application => applicationInProgress.value;
  final debitCardOptions = <OAODebitCard>[].obs;


  String get checkingApy => checkingProducts.first.apy;
  String get savingApy => savingsProducts.first.apy;

  double get checkingApyDouble =>
      double.tryParse(checkingApy.replaceAll('%', '')) ?? 0.0;
  double get savingApyDouble =>
      double.tryParse(savingApy.replaceAll('%', '')) ?? 0.0;

  final applicationInProgress = OAOMemberApplication(
    mailingAddress: PartialAddress(),
    address: PartialAddress(),
  ).obs;

  final workflowOptions = OAOWorkflowOptions(
    ignoreFailedAPICall: false,
    mockAPI: OAOWorkflowOptions.successfulMockAPI,
  );

  final loading = false.obs;

  final bool fromEBS;

  OAOController({this.fromEBS = false});

  @override
  void onInit() {
    if (fromEBS == false) {
      _prefillApplication();
      _fetchCheckingSavingsProducts();
      _fetchCdProducts();
    }

    super.onInit();
  }

  _onActionWrapper(Function function) async {
    if (loading.value == true) {
      return;
    }
    loading.value = true;
    try {
      var result = await function();
      loading.value = false;
      return result;
    } catch (e) {
      loading.value = false;
      Log.error(e.toString());
      Get.to(() => OAOErrorScreen());
    }
  }

  void _prefillApplication() {
    // A lot of data will already exist in Profile model
    final profileModel = Get.find<ProfileController>().userProfile;
    applicationInProgress.value.firstName = profileModel.firstName;
    applicationInProgress.value.lastName = profileModel.lastName;
    applicationInProgress.value.middleName = profileModel.middleName;
    applicationInProgress.value.dob = profileModel.birthDate;

    applicationInProgress.value.phoneNumber = profileModel.phoneNumber;
    applicationInProgress.value.email = profileModel.email;
    // _prefillAddress();
  }

  void _prefillAddress() async {
    try {
      final _dataHelper = DataHelperImpl.instance;
      final response = await _dataHelper.apiHelper.fetchAddress();
      await response.fold((l) {
        ///as of now we are getting 500 when user has no address
        Log.error('Error fetching address');
        apiExceptionMessage(l.errorCode);
      }, (res) {
        if (res != null && res['success'] && applicationInProgress.value.address.line1 == null) {
          AddressData addressData = AddressData.fromJson(res['data']['Address']);
          applicationInProgress.value.address.line1 = addressData.addrAddressLine1;
          applicationInProgress.value.address.line2 = addressData.addrAddressLine2;
          applicationInProgress.value.address.zip = addressData.addrPostalCode;
          applicationInProgress.value.address.city = addressData.addrCity;
          applicationInProgress.value.address.state(addressData.addrState);
        }
      });
    } catch (e) {
      Log.error('Error fetching address');
      Log.error(e.toString());
    }
  }

  _fetchCheckingSavingsProducts() async {
    return await _onActionWrapper(() async {
      final _products = await _service.getCheckingProducts() as List<OAODepositAccount>;
      final _savings = await _service.getSavingsProducts() as List<OAODepositAccount>;
      checkingProducts.value = _products;
      savingsProducts.value = _savings;
    });
  }

  _fetchCdProducts() async {
    if (cdProducts.isNotEmpty) {
      return;
    }

    return await _onActionWrapper(() async {
      final _cds = await _service.getCdProducts() as List<OAODepositAccount>;
      cdProducts.value = _cds;
    });
  }

  fetchDebitCardOptions() async {
    if (debitCardOptions.isNotEmpty) {
      // There is a bug where selectedCard is not getting set. Not sure why so adding it here
      if (applicationInProgress.value.selectedCard.value.cardArt == '') {
        applicationInProgress.value.selectedCard(debitCardOptions.first);
      }
      return;
    }

    return await _onActionWrapper(() async {
      final options = await _service.getDebitCardOptions() as List<OAODebitCard>;
      debitCardOptions.value = options;
      applicationInProgress.value.selectedCard(options.first);
    });
  }

  verifyAddress(PartialAddress address) async {
    List errors = await _service.verifyAddress(address);
    if (errors.length != 0) {
      address.errors.clear();

      address.errors.addAll(errors);
    } else {
      address.errors.clear();
    }
  }

  onBeginApplication(OAODepositAccount product) async {
    return await _onActionWrapper(() async {
      // Start fetching disclosures when we start rather than when we get to review
      final disclosures = await _service.getDisclosures(product);
      productDisclosures.value = disclosures;
      if (productDisclosures.isEmpty) {
        return Get.to(() => OAOErrorScreen());
      }

      final quickApp = await _service.attemptQuickApply(product);
      if (quickApp != null) {
        applicationInProgress.value = quickApp;
        Get.to(() => OAOReviewApplicationScreen());
      } else {
        applicationInProgress.value.selectedProduct = product;
        Get.to(() => OAOPersonalInformationScreen());
      }
    });
  }

  fetchFundingAccounts() async {
    try {
      final _fundingAccounts =
          await _service.getFundingAccounts(application.selectedProduct!.group == "CD") as OAOFundingAccountsModel;
      fundingAccountsData.value = _fundingAccounts;
    } catch (e) {
      Log.error(e.toString());
    }
  }

  Future<dynamic> makeDeposit(double amount) async {
    return await _onActionWrapper(() async {
      var res;
      if (application.selectedProduct!.group == "CD") {
        res = await _service.submitApplicationAndMakeDeposit(
            application: application,
            amount: amount,
            acctId: applicationInProgress.value.accountId!,
            linkedAccountId: selectedFundingAccount.value!.id,
            isInternal: selectedFundingAccountIsGlorifi.value == true);
        applicationInProgress.value.accountNumber = res["accountNumber"];
        applicationInProgress.value.routingNumber = res["routingNumber"];
        applicationInProgress.value.accountId = res["accountId"];
        application.fundedAmount = amount;
      } else {
        res = await _service.makeDeposit(
            amount: amount,
            acctId: applicationInProgress.value.accountId!,
            linkedAccountId: selectedFundingAccount.value!.id,
            isInternal: selectedFundingAccountIsGlorifi.value == true);
        application.fundedAmount = amount;
      }
      return res;
    });
  }

  onConfirmCitizenship() async {
    Get.to(
      () => OAOReviewApplicationScreen(),
    );
  }

  onConfirmSsn() async {
    Get.to(
      () => OAOVerifyCitizenshipScreen1(),
    );
  }

  onOrderDebitCard() async {
    return await _onActionWrapper(() async {
      final errorMessage = await _service.orderDebitCard(applicationInProgress.value);
      if (errorMessage == null) {
        // Treated as success
        if (fromEBS) {
          // TODO: Probably want to go to a success screen. The success screen needs to go back to Account WHILE ENSURING THE CONTROLLERS CREATED ARE DISPOSED
          return Get.offAllNamed(Routes.cockpit);
        }
        Get.to(() => OAOExitScreen());
      } else {
        Get.to(() => OAOErrorScreen());
      }
    });
  }

  onSubmitApplication() async {
    return await _onActionWrapper(() async {
      application.isError(false);

      if (application.ssn != null) {
        // this is not a quickApply account
        List<int> successStatus = [200, 201];
        final res = await _service.createUser(applicationInProgress.value);
        if (res["success"] == true) {
          if (successStatus.contains(res["data"]["accountCreation"]["statusCode"]) &&
              successStatus.contains(res["data"]["applicationValidation"]["statusCode"]) &&
              successStatus.contains(res["data"]["submitApplication"]["statusCode"])) {
          } else if (res["data"]["status"] == "TBD") {
            Get.to(
              () => OAOFurtherReview(),
            );
          } else {
            return application.isError(true);
          }
        } else {
          return Get.to(() => OAOErrorScreen());
        }
      }

      if (application.selectedProduct!.group != "CD") {
        final res = await _service.submitApplication(applicationInProgress.value);
        applicationInProgress.value.accountNumber = res["accountNumber"];
        applicationInProgress.value.routingNumber = res["routingNumber"];
        applicationInProgress.value.accountId = res["accountId"];
      }
      await fetchFundingAccounts();
      // TODO: at this step we check info from server to decide which screen to show
      if (fundingAccountsData.value != null &&
          (!fundingAccountsData.value!.glorifiAccounts.isEmpty || !fundingAccountsData.value!.linkedAccounts.isEmpty)) {
        Get.to(() => OAOFundingAccountsScreen());
      } else {
        Get.to(() => OAOFundYourAccountPlaidScreen());
      }
    });
  }

  selectProduct(OAODepositAccount product) {
    if (applicationInProgress.value.selectedProduct?.name == product.name) {
      applicationInProgress.value.selectedProduct = null;
    } else {
      applicationInProgress.value.selectedProduct = product;
    }
    refresh();
  }

  static void showGenericErrorSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text(
        'An error occurred while processing your application. Please try again later.',
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  selectFundingAccount(dynamic account) {
    if (account is FundingGlorifiAccount) {
      selectedFundingAccount.value = FundingLinkedAccountModel(
        id: account.coreAccountId,
        name: account.accountName,
        balance: account.balance,
        institution: 'GloriFi',
        mask: account.accountNumber.substring(account.accountNumber.length - 4, account.accountNumber.length),
      );
      selectedFundingAccountIsGlorifi.value = true;
    } else {
      selectedFundingAccount.value = account;
      selectedFundingAccountIsGlorifi.value = false;
    }

    Get.to(OAODepositScreen());
  }
}
