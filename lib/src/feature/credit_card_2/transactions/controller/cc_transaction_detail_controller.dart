import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/model/cc_transaction_details_model.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/service/cc_merchant_detail_service.dart';

class CCTransactionDetailController extends GetxController {
  final _service = Get.find<CCMerchantDetailService>();
  final CCTransactionDetailsModel transaction =
      Get.arguments as CCTransactionDetailsModel;
  var disputeTransactionBalance;
  RxMap<String, dynamic> merchantDetails = RxMap<String, dynamic>();

  CCTransactionDetailController() {
    disputeTransactionBalance = [
      transaction.amount!.toStringAsFixed(2),
      transaction.tip_amount?.toStringAsFixed(2)
    ];
  }

  @override
  void onInit() {
    _fetchMerchantDetail();
    super.onInit();
  }

  _fetchMerchantDetail() async {
    try {
      final res = await _service.getCCMerchantDetails(
          merchantId: "merchant-id"); // TODO: Pass merchant ID
      merchantDetails.value = res;
      print("merchantDetails: $merchantDetails");
    } catch (e) {
      log(e.toString());
    }
  }

  // Mock Data
  var merchantName = "Target Cafe".obs;
  var merchantIcon = [Icons.my_location].obs;

  var transactionDate = "July 2, 2022".obs;
  var transactionTime = "2:45 PM".obs;
  var transactionStatus = "Pending".obs;
  var transactionAmount = "42.00".obs;

  var year = "2022".obs;
  var totalBalance = "500.00".obs;

  var disputeTransactionTitle = ["Value", "Tip Added"].obs;
  var disputeTransactionIcon =
      [Icons.account_balance_wallet_outlined, Icons.favorite_outline_sharp].obs;

  var transactionListCount = 3.obs;
  var transactionListTitle = ["Target", "Target", "Target"].obs;
  var transactionListIcon = [
    Icons.track_changes_outlined,
    Icons.track_changes_outlined,
    Icons.track_changes_outlined
  ].obs;
  var transactionListBalance = ["40.00", "30.00", "20.00"].obs;
  var transactionListDate =
      ["May 20, 2022", "May 20, 2022", "May 20, 2022"].obs;
  var transactionListStatus = ["Pending", "Pending", ""].obs;
}
