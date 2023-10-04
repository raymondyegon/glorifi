// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:http/http.dart' as http;

import 'account_model.dart';

class SavingsCheckingsController extends GetxController with StateMixin {
  final _apiHelper = DataHelperImpl.instance.apiHelper;
  final memberId = Get.find<ProfileController>().userProfile.memberId;

  var totalBalance = 0.0.obs;
  List<Account> accounts = <Account>[].obs;
  List<ChartData> history = <ChartData>[].obs;
  var selectedAccount = 0.obs;

  final type;

  SavingsCheckingsController(this.type);

  @override
  void onInit() {
    mapAccountOverviewDetails();
    selectedAccount.value = -1;
    super.onInit();
  }

  Future<Map<String, dynamic>> getAccountDetail() async {
    try {
      final res = await _apiHelper.getSavingsCheckingDetail(type);
      return res['data'] as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> getThirtyDayBalance(String accountId) async {
    try {
      final res = await _apiHelper.getThirtyDayDetails(accountId);
      return res['data'] as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  mapAccountOverviewDetails() async {
    var accountResponse = await getAccountDetail();

    totalBalance.value = accountResponse['total-balance'];
    history = getXAxisDates(accountResponse['30-day-history']);

    List accountsList = accountResponse['accounts'];
    if (accountsList.isEmpty) {
      change(() {}, status: RxStatus.empty());
    }
    for (var i = 0; i < accountsList.length; i++) {
      var currAccount = accountsList[i];
      var thirtydayDayResponse = await getThirtyDayBalance(currAccount['id']);
      List<ChartData> thirtydayData = getXAxisDates(thirtydayDayResponse);

      String base64String = currAccount['base64-logo'];
      Image logoImage = Image.memory(
        base64Decode(base64String),
        width: 50,
        height: 50,
      );
      accounts.add(
        Account(
          accountId: currAccount['id'],
          balance: currAccount['balance'],
          institution: currAccount['institution'],
          name: currAccount['name'],
          mask: currAccount['mask'],
          logo: logoImage,
          thirtyDayBalance: thirtydayData,
        ),
      );
    }
    change(() {}, status: RxStatus.success());
  }

  List<ChartData> getXAxisDates(cohData) {
    List<ChartData> arr = [];
    cohData.forEach((key, value) {
      var splitData = key.split('-');
      int year = int.parse(splitData[0]);
      int month = int.parse(splitData[1]);
      int day = int.parse(splitData[2]);

      var datetime = DateTime(year, month, day);
      arr.add(ChartData(datetime, value));
    });
    arr.sort((a, b) => a.x.compareTo(b.x));
    return arr;
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;

  @override
  String toString() {
    // TODO: implement toString
    return x.toString() + ", " + y.toString() + "\n";
  }
}
