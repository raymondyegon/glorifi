import 'dart:developer';

import 'package:get/get.dart';
import 'package:glorifi/src/controllers/account_flags_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_models.dart';
import 'package:intl/intl.dart';

class InsightsController extends GetxController with StateMixin {
  var topInsightsModelList = <InsightsModel>[].obs;

  //Read
  var inboxInsightsModelList = <InsightsModel>[].obs;
  List teaserTypes = [].obs;
  List teaserTitles = [].obs;
  List teaserBodies = [].obs;
  List teaserDates = [].obs;
  final memberId = Get.find<ProfileController>().userProfile.memberId;
  final userEmail = Get.find<ProfileController>().userProfile.email;
  final AccountFlagsController accountFlagsController =
      Get.put(AccountFlagsController());

  final _dataHelper = DataHelperImpl.instance;

  int insightAutoRetryCount = 0;

  @override
  void onInit() {
    super.onInit();
    loadInboxData();
    getApiToken();
  }

  pullToRefresh() async {
    topInsightsModelList.clear();
    inboxInsightsModelList.clear();
    teaserTypes.clear();
    teaserTitles.clear();
    teaserBodies.clear();
    teaserDates.clear();
    await loadInboxData();
    await getApiToken();
  }

  getApiToken() async {
    var token = await _dataHelper.cacheHelper.getAccessToken();
    log("$userEmail's Token: $token");
  }

  //Get Insights Personetics API Request
  getInsights() async {
    Map<String, dynamic> params = {
      "type": "getInsights",
      "protocolVersion": "2.6",
      "autoGenerate": true,
      "ctxId": "showAll",
      "lang": "en",
    };
    Map<String, dynamic> headers = {
      "authToken": "$memberId",
      "Content-Type": "application/json",
    };
    Map<String, dynamic> qaHeaders = {
      "authToken": "$memberId",
      "Content-Type": "application/json",
      "effectiveTime": "01/03/2017"
    };
    final response = userEmail!.contains("qa+insight")
        ? await _dataHelper.apiHelper
            .getPersoneticsQAInsights(qaHeaders, params)
        : await _dataHelper.apiHelper.getPersoneticsInsights(headers, params);
    var mMap;
    try {
      await response.fold(
        (l) {
          if (insightAutoRetryCount == 0) {
            insightAutoRetryCount = 1;
            getInsights();
          } else {
            Log.error(l.errorMessage);
            insightAutoRetryCount = 0;
          }
        },
        (res) {
          if (res["status"] == 500) {
            if (insightAutoRetryCount == 0) {
              insightAutoRetryCount = 1;
              getInsights();
            } else {
              change(res, status: RxStatus.empty());
              insightAutoRetryCount = 0;
            }
          }
          if (res != null && res['ok'] == true) {
            change(res, status: RxStatus.success());
            mMap = res;
          }
        },
      );
    } catch (e) {
      Log.error(e);
      change(e, status: RxStatus.error());
      return mMap;
    }
    return mMap;
  }

  loadInboxData() async {
    var insightObject = await getInsights();
    if (insightObject != null) {
      List insightsList = insightObject["insights"];

      List<InsightsModel> insights = List<InsightsModel>.from(
          insightsList.map((item) => InsightsModel.fromJson(item)));
      if (insights.isEmpty) {
        change(() {}, status: RxStatus.empty());
      }
      for (var i = 0; i < insights.length; i++) {
        var teasers = insights[i].teaserBlocks;

        String? title = teasers![2].text;
        String? body = teasers[3].text ?? "";
        String? type = insights[i].teaserTemplate;
        String? date = insights[i].generatedDate;
        late String finalDate = '';
        if (date != null) {
          //Format Date
          var dateFormatted =
              date.substring(0, 10) + ' ' + date.substring(11, 23);
          DateTime dt = DateTime.parse(dateFormatted);
          finalDate = DateFormat("MMM d yyyy").format(dt);
        }

        // add values to observable arrays
        teaserTypes.add(type);
        teaserTitles.add(title);
        teaserBodies.add(body);
        teaserDates.add(finalDate);
        inboxInsightsModelList.add(insights[i]);
      }
    }
  }

  //TODO do this after successful deleteInsight api call ?
  removeInsight(String insightId) {
    int index =
        inboxInsightsModelList.indexWhere((element) => element.id == insightId);
    teaserTypes.removeAt(index);
    teaserTitles.removeAt(index);
    teaserBodies.removeAt(index);
    teaserDates.removeAt(index);
    inboxInsightsModelList.removeAt(index);
    if (inboxInsightsModelList.isEmpty) {
      change(() {}, status: RxStatus.empty());
    }
  }

//TODO Implement this once we are using REAL insights
  deleteInsight(insightId) async {
    Map<String, dynamic> params = {
      "type": "setInsightPreferences",
      "protocolVersion": "2.6",
      "settings": {
        "insightsTag": {
          "$insightId": {"preferenceType": "hide"}
        }
      }
    };
    Map<String, dynamic> headers = {
      "authToken": "$memberId",
      "Content-Type": "application/json"
    };
    final response =
        await _dataHelper.apiHelper.getPersoneticsInsights(headers, params);
    var mMap;
    try {
      await response.fold(
        (l) {
          Log.error(l.errorMessage);
        },
        (res) {
          if (res != null && res['ok']) {
            change(res, status: RxStatus.success());
            mMap = res;
          }
        },
      );
    } catch (e) {
      Log.error(e);
      change(e, status: RxStatus.error());
      return mMap;
    }
    return mMap;
  }
}
