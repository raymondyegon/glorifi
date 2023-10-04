// ignore_for_file: avoid_Log.error

import 'dart:convert';

import 'package:get/get.dart';
import 'package:glorifi/src/core/api/api_endpoints.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:dio/dio.dart' as dio;
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../../../../../../../controllers/profile_controller.dart';

class InsightsStoryController extends GetxController with StateMixin {
  // RxList getInsightsJson = [].obs;

  var payload = "".obs;
  late WebViewPlusController webController;
  final _dataHelper = DataHelperImpl.instance;
  final memberId = Get.find<ProfileController>().userProfile.memberId;
  final userEmail = Get.find<ProfileController>().userProfile.email;




  getInsightDetailsForWeb(jsonFromWeb) async {
    String url =
        '${ApiEndPoints.apiBaseUrl}/insights/glorifi-test/execute?channel=GLORIFI_LIVE';

    var params = jsonFromWeb;

    var headers = {"authToken": "$memberId"};
    try {
      var response = await dio.Dio().post(
        url,
        options: dio.Options(
          headers: headers,
        ),
        data: jsonEncode(params),
      );
      var responseBody = response.data;
      var encoded = json.encode(responseBody);

      return encoded;
    } catch (e) {
      Log.error(e);
      change(e, status: RxStatus.error());
    }
  }

  getInsightDetails(jsonFromWeb) async {
    Map<String, dynamic> params = jsonFromWeb;
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
    }
    return mMap;
  }


}
