// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/api/api_endpoints.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/eligible_accounts_model.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_success.dart';
import 'package:http/http.dart';

class TransferController extends GetxController with StateMixin {
  Rx<TextEditingController> amountController = TextEditingController().obs;
  RxDouble availableBalanceInFromAccount = 0.0.obs;
  RxDouble transferAmount = 0.0.obs;
  var glorifiAccountsModelList = <GlorifiAccounts>[].obs;
  var linkedAccountsModelList = <LinkedAccounts>[].obs;
  final _dataHelper = DataHelperImpl.instance;
  RxBool accountsFetched = false.obs;
  late String transferConfirmation;

  List<GlorifiAccounts>
      get glorifiAccountsModelListFrom => glorifiAccountsModelList
          .where((p0) =>
              selectedGlorifiAccountTo?.value?.accountNumber !=
              p0.accountNumber)
          .toList();

  List<GlorifiAccounts> get glorifiAccountsModelListTo =>
      glorifiAccountsModelList
          .where((p0) =>
              selectedGlorifiAccountFrom?.value?.accountNumber !=
              p0.accountNumber)
          .toList();

  Rxn<GlorifiAccounts>? selectedGlorifiAccountTo = Rxn<GlorifiAccounts>();
  Rxn<GlorifiAccounts>? selectedGlorifiAccountFrom = Rxn<GlorifiAccounts>();
  Rxn<LinkedAccounts>? selectedLinkedAccountFrom = Rxn<LinkedAccounts>();
  Rxn<LinkedAccounts>? selectedLinkedAccountTo = Rxn<LinkedAccounts>();

  //Will Either be Glorifi or Plaid
  RxString selectedFromAccountType = ''.obs;
  RxString selectedToAccountType = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // updateAmount(val) {
  //   return val = transferAmount.value;
  // }

  fetchEligibleTransferAccounts() async {
    final response = await _dataHelper.apiHelper.getEligibleTransferAccounts();
    return response.fold((l) {
     
    }, (r) {
      change(r, status: RxStatus.success());
      accountsFetched.value = true;
      return r;
    });
  }

  resetTransferAccounts() {
    accountsFetched.value = false;
    glorifiAccountsModelList.value = [];
    linkedAccountsModelList.value = [];
    // Ensure that the sections show a shimmer when they reload
    change({}, status: RxStatus.loading());
  }

  mapEligibleAccountsData() async {
    
    var data = await fetchEligibleTransferAccounts();
    if (data != null) {

      //Add Glorifi Accounts To Observable Variable
      List glorifiAccountsList = data.data.glorifiAccounts;

      for (var i = 0; i < glorifiAccountsList.length; i++) {
        glorifiAccountsModelList.add(glorifiAccountsList[i]);
      }

      //Add Linked Accounts To Observable Variable
      List linkedAccountsList = data.data.linkedAccounts;
      if (linkedAccountsList.isEmpty && glorifiAccountsList.isEmpty) {
        change(() {}, status: RxStatus.empty());
      }
      for (var i = 0; i < linkedAccountsList.length; i++) {
        linkedAccountsModelList.add(linkedAccountsList[i]);
      }
    }
  }

  //This will return either internal, outgoing, or incoming
  retrieveRequestMethod() {
    if (selectedFromAccountType.value == "Glorifi" &&
        selectedToAccountType.value == "Glorifi") {
      return "internal";
    }
    if (selectedFromAccountType.value == "Linked" &&
        selectedToAccountType.value == "Glorifi") {
      return "incoming";
    }
    if (selectedFromAccountType.value == "Glorifi" &&
        selectedToAccountType.value == "Linked") {
      return "outgoing";
    }
    if (selectedFromAccountType.value == "Linked" &&
        selectedToAccountType.value == "Linked") {
      return null;
    }
  }

  transferAPIRequest(method) async {
    Map<String, dynamic> body = method == "internal"
        ? {
            //Money will be deposited into this account
            "counterParty": {
              "acctId": selectedGlorifiAccountTo!.value!.coreAccountId,
              "posnId": selectedGlorifiAccountTo!.value!.bankAccountId,
            },
            //Money will be withdrawn from this account
            "originator": {
              "acctId": selectedGlorifiAccountFrom!.value!.coreAccountId,
              "posnId": selectedGlorifiAccountFrom!.value!.bankAccountId,
            },
            "amount": transferAmount.value,
          }
        :
        //Body for Outgoing or Incoming Transfers
        method == "outgoing"
            ? {
                "originator": {
                  "acctId": selectedGlorifiAccountFrom!.value!.coreAccountId,
                  "posnId": selectedGlorifiAccountFrom!.value!.bankAccountId,
                },
                "counterParty": {
                  "linkedAccountId": selectedLinkedAccountTo!.value!.id,
                },
                "amount": transferAmount.value,
              }
            :
            //Incoming Transfer
            {
                "originator": {
                  "acctId": selectedGlorifiAccountTo!.value!.coreAccountId,
                  "posnId": selectedGlorifiAccountTo!.value!.bankAccountId,
                },
                "counterParty": {
                  "linkedAccountId": selectedLinkedAccountFrom!.value!.id,
                },
                "amount": transferAmount.value,
              };

    try {
      final response =
          await DataHelperImpl.instance.apiHelper.makeTransfer(method, body);
      transferConfirmation = response['data']['_Id'] ?? '';
      return Get.to(() => TransferSuccess());
    } catch (e) {
      // TODO: Handle this
      Log.error("Error submitting transfer");
    }
  }

  Future submitTransfer() async {
    var requestMethod = retrieveRequestMethod();
    return await transferAPIRequest(requestMethod);
  }
}
