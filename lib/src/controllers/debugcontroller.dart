import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/services/okta_api_service.dart';

class DebugController extends GetxController with StateMixin {
  final OKTA_APIService _okta_apiService = Get.find<OKTA_APIService>();
  var at = "".obs;
  var rt = "".obs;
  var accessToken = ''.obs;
  var dataHelper = DataHelperImpl.instance;

  @override
  void onInit() {
    dataHelper.cacheHelper.getAccessToken().then((value) => {at.value = value});
    dataHelper.cacheHelper
        .getRefreshToken()
        .then((value) => {rt.value = value});
    super.onInit();
  }

  getAccessToken({required String refreshToken}) async {
    final response = await _okta_apiService.getAccessToken(
        grant_type: "refresh_token",
        client_id: "0oa22l89upDJGfZgm1d7",
        scope: "offline_access openid",
        refresh_token: refreshToken);
    response.fold((l) {
      if (l.errorCode == 400) {
        change(
          'Refresh token has expired. Click to login again.',
          status: RxStatus.error(),
        );
      }
    }, (r) {
      change(r, status: RxStatus.success());
    });
  }
}
