import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/account_flags_controller.dart';
import 'package:glorifi/src/controllers/home_value_controller.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/model/personal_snapshot/net_worth_detail_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/net_worth_details_service.dart';
import 'package:glorifi/src/widgets/charts/chart_data_models.dart';

class NetWorthController extends GetxController {
  String currentScreen = 'Net worth detail screen';
  final _apiHelper = DataHelperImpl.instance.apiHelper;

  final AccountFlagsController accountFlagsController =
      Get.put(AccountFlagsController());
  final HomeValueController homeValueController =
      Get.put(HomeValueController());
  PlaidController plaidController = Get.put(PlaidController());

  Rx<NetWorthDetailModel>? netWorthDetail;

  List<GraphData> graphData = <GraphData>[].obs;

  Rx<String> statusApi = ''.obs;
  final RxBool loading = false.obs;

  var totalAmount = 0.0.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    try {
      loading.value = true;

      var service = await NetWorthDetailsService();

      NetWorthDetailModel response =
          await service.getNetWorthDetails() as NetWorthDetailModel;

      var data = await getNetWorthGraphDetail();
      print('networth graph');
      print(
          '*****************************************************************************************************************************************************************************************************************************************************************************************************************************************************');
      graphData = getXAxisDates(data!['net_worth']);
      netWorthDetail = response.obs;
      netWorthDetail?.refresh();
      statusApi('success');
    } catch (e) {
      statusApi('500');
      Log.error(e);
    } finally {
      loading.value = false;
    }
  }

  Future<Map<String, dynamic>?> getNetWorthGraphDetail() async {
    try {
      final res = await _apiHelper.getCashOnHandNetWorthDetails();
      return res['data'] as Map<String, dynamic>;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // openComparison(bool isDevice) {
  //   if (isDevice) {
  //     Get.bottomSheet(
  //       CompareValueScreen(
  //         gloriFiCompareState: GloriFiCompareType.netWorth,
  //         member: netWorthDetail?.value.totalAmount.toString(),
  //       ),
  //       barrierColor: GlorifiColors.barrierColor,
  //       isScrollControlled: true,
  //       isDismissible: false,
  //     );
  //   } else {
  //     Get.defaultDialog(
  //       backgroundColor: Colors.transparent,
  //       title: '',
  //       content: CompareValueDialog(
  //           gloriFiCompareState: GloriFiCompareType.netWorth,
  //           cardId: netWorthDetail!.value.cardId),
  //       radius: 5.r,
  //     );
  //   }
  // }

  plaidLinkOpen() => plaidController.openPlaid();

  creditOpen() => Get.toNamed(Routes.enableCreditScoreStep1Name);
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
