// ignore_for_file: avoid_print


import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/widgets/charts/chart_data_models.dart';
import 'package:intl/intl.dart';

import 'cash_on_hand_models.dart';

class CashOnHandController extends GetxController with StateMixin {
  final _apiHelper = DataHelperImpl.instance.apiHelper;

  final memberId = Get.find<ProfileController>().userProfile.memberId;
  final getCashOnHandModel = Rxn<GetCashOnHandModel>();
  var totalCheckingAmount = 0.0.obs;
  var totalSavingsAmount = 0.0.obs;
  var totalAmount = 0.0.obs;

  List checkingAccounts = <CheckingAccounts>[].obs;
  List savingsAccounts = <SavingsAccounts>[].obs;

  List netWorthData = <GraphData>[].obs;
  List cohData = <GraphData>[].obs;

  var indexNumber = 0.obs;
  var cardNumber = 2.obs;

  var loading = true.obs;

  @override
  void onInit() {
    mapGetCashOnHandData();
    super.onInit();
  }

  Future<GetCashOnHandModel?> getCashOnHandDetail() async {
    try {
      final res = await _apiHelper.getCashOnHandDetailsVersion2();
      return GetCashOnHandModel.fromJson(res['data'] as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCohVNetworthDetail() async {
    try {
      final res = await _apiHelper.getCashOnHandNetWorthDetails();
      return res['data'] as Map<String, dynamic>;
    } catch (e) {
      print(e);
      return null;
    }
  }

  mapGetCashOnHandData() async {
    checkingAccounts.clear();
    savingsAccounts.clear();
    loading.value = true;
    var cohResponse = await getCashOnHandDetail();
    var cohNetWorthResponse = await getCohVNetworthDetail();

    if (cohResponse == null || cohNetWorthResponse == null) {
      change(() {}, status: RxStatus.error());
      return;
    }

    netWorthData = getXAxisDates(cohNetWorthResponse['net_worth']);
    cohData = getXAxisDates(cohNetWorthResponse['cash_on_hand']);

    totalCheckingAmount.value = cohResponse.checkingAmount;
    totalSavingsAmount.value = cohResponse.savingsAmount;
    totalAmount.value = cohResponse.totalAmount;

    List checkingAccountsList = cohResponse.checkingAccounts;

    for (var i = 0; i < checkingAccountsList.length; i++) {
      checkingAccounts.add(checkingAccountsList[i]);
    }
    List savingsAccountsList = cohResponse.savingsAccounts;
    if (savingsAccountsList.isEmpty && checkingAccountsList.isEmpty) {
      change(() {}, status: RxStatus.empty());
    }
    for (var i = 0; i < savingsAccountsList.length; i++) {
      savingsAccounts.add(savingsAccountsList[i]);
    }
    change(() {}, status: RxStatus.success());
    loading.value = false;
  }

  List<GraphData> getXAxisDates(cohData) {
    List<GraphData> arr = [];
    cohData.forEach((key, value) {
      var splitData = key.split('-');
      int year = int.parse(splitData[0]);
      int month = int.parse(splitData[1]);
      int day = int.parse(splitData[2]);

      var datetime = DateTime(year, month, day);
      arr.add(GraphData(datetime, value));
    });
    arr.sort((a, b) => a.x.compareTo(b.x));
    return arr;
  }

  String formatBalance(double balance) {
    double d = balance;
    var format =
        NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: "\$");
    String parsedCurrentBalance = format.format(d);
    return parsedCurrentBalance;
  }

  updateIndex(int index) {
    print(index);
    indexNumber.value = index;
    // change(() {}, status: RxStatus.success());
  }
}
