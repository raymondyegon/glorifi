// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/widgets/charts/chart_data_models.dart';
import 'package:http/http.dart' as http;

class AccountDetailsPageController extends GetxController with StateMixin {
  final memberId = Get.find<ProfileController>().userProfile.memberId;

  final String accountId;
  List<GraphData> graphData = <GraphData>[].obs;
  List<Transaction> activities = <Transaction>[];

  AccountDetailsPageController(this.accountId);

  @override
  void onInit() {
    mapAccountDetails();
    super.onInit();
  }

  Future<Map<String, dynamic>> getThirtyDayBalance() async {
    Uri url = Uri.parse(
        'https://animo-testapimgmt.azure-api.net/data-services/accounts/$accountId/thirty-day-balance');
    print('account id:' + accountId.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    }
    print(response.reasonPhrase);
    return {};
  }

  Future<Map<String, dynamic>> getTransactionHisotry() async {
    Uri url = Uri.parse(
        'https://animo-testapimgmt.azure-api.net/data-services/accounts/$accountId/transaction-history?offset=10&amount=1');

    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    }
    print(response.reasonPhrase);
    return Future.error('Server error.');
  }

  mapAccountDetails() async {
    // TODO: replace with API
    Map<String, dynamic> transactionsResponse;
    var graphDataResponse;
    try {
      transactionsResponse = await getTransactionHisotry();
      graphDataResponse = await getThirtyDayBalance();
      print('try');
      change(() {}, status: RxStatus.success());
    } catch (err) {
      change(() {}, status: RxStatus.error());
      return;
    }

    print(transactionsResponse);

    if (graphDataResponse.isEmpty || transactionsResponse.isEmpty) {
      change(() {}, status: RxStatus.empty());
    }

    graphData = getXAxisDates(graphDataResponse);
    activities = getActivities(transactionsResponse['transactions']);

    print(activities);
  }

  List<Transaction> getActivities(List data) {
    List<Transaction> transactions = [];
    for (int i = 0; i < data.length; i++) {
      var tx = data[i];
      var splitData = tx['date'].toString().split('-');
      int year = int.parse(splitData[0]);
      int month = int.parse(splitData[1]);
      int day = int.parse(splitData[2]);
      var datetime = DateTime(year, month, day);
      Transaction transaction = Transaction(
        date: datetime,
        name: tx['name'],
        amount: tx['amount'],
        pending: tx['pending'],
        type: tx['type'],
      );
      transactions.add(transaction);
    }
    print(transactions);
    return transactions;
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
}

class ActivityGroup {
  DateTime date;
  List<Transaction> transactions = <Transaction>[];
  ActivityGroup(this.date, this.transactions);
}

class Transaction {
  String name;
  double amount;
  bool pending;
  String type;
  DateTime date;

  Transaction({
    required this.date,
    required this.name,
    required this.amount,
    required this.pending,
    required this.type,
  });
}
