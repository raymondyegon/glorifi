import 'dart:developer';

import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/cc_dashboard_service.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_card_model.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_dashboard_model.dart';
import 'package:intl/intl.dart';

import '../transactions/model/cc_transaction_details_model.dart';

class CCDashboardController extends GetxController {
  final _service = Get.find<CCDashboardService>();
  final CCDashboardModel accountModel;
  RxMap<String, RxList<CCTransactionDetailsModel>> transactions =
      RxMap<String, RxList<CCTransactionDetailsModel>>();
  RxList<CCCardModel> cards = RxList<CCCardModel>();
  bool isMockEnabled = false;

  int get daysUntilBillDue =>
      (accountModel.dueDate.difference(DateTime.now()).inHours / 24).round();

  RxInt carouselIndex = 0.obs;
  RxInt loadTransferIndex = 0.obs;
  CCDashboardController(
      {required this.accountModel, required this.isMockEnabled});

  @override
  void onInit() {
    _getCards();
    _fetchTransactions();
    super.onInit();
  }

  _getCards() {
    CCDashboardCardType.values.forEach((cardType) {
      var card = getCardData(cardType);
      if (card != null) {
        cards.add(card);
      }
    });
  }

  getCardData(CCDashboardCardType cardType) {
    switch (cardType) {
      case CCDashboardCardType.ActivateCard:
        if (accountModel.status != CCStatus.ACTIVE) {
          return CCCardModel(
              title: 'Activate Your Physical Card',
              subText:
                  'For your security only activate it once you’ve receive it via mail');
        }
        break;
      case CCDashboardCardType.ActiveDispute:
        if (accountModel.numberActiveDisputes == 1) {
          return CCCardModel(
              title: 'You have an active dispute',
              subText: 'Track or withdraw your dispute');
        } else if (accountModel.numberActiveDisputes > 1) {
          return CCCardModel(
              title: 'You have an active dispute',
              subText: 'Track or withdraw your dispute');
        }
        break;
      case CCDashboardCardType.AccountSuspended:
        if (accountModel.status == CCStatus.SUSPENDED) {
          return CCCardModel(
              title: 'Account suspended',
              subText:
                  'Please contact support to resolve outstanding issues with your card');
        }
        break;
      case CCDashboardCardType.PaymentDue:
        if (daysUntilBillDue < 10) {
          return CCCardModel(
              title: 'Payment due in $daysUntilBillDue days',
              subText:
                  'Minimum due is \$${accountModel.remainingMinimumPaymentDue}');
        }
        break;
      default:
    }
  }

  _fetchTransactions() async {
    String _date(DateTime d) {
      return DateFormat.MMMd().format(d);
    }

    try {
      final res = await _service.getCCTransactions(isMockEnabled,
          loadMoreIndex: loadTransferIndex.value);

      res.forEach((t) {
        String _dateString = _date(t.transacted_at!);
        if (transactions.containsKey(_dateString)) {
          transactions[_dateString]!.add(t);
        } else {
          transactions[_dateString] = [t].obs;
        }
      });
    } catch (e) {
      print("fetch error");
      log(e.toString());
    }
  }

  fetchMoreTransactions() async {
    loadTransferIndex++;
    await _fetchTransactions();
  }
}
