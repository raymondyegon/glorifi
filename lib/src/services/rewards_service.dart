import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';

class RewardsService extends GetxService {
  RewardsService();
  final _apiHelper = DataHelperImpl.instance.apiHelper;
  LoyaltyController get loyaltyController => Get.find<LoyaltyController>();
  bool sharedAppFlag = false;
  bool allowCameraAccessFlag = false;
  bool allowLocationPermissionFlag = false;


  static void sharedApp() {
    final _service = Get.find<RewardsService>();
    _service._sharedApp();
  }


  static void allowCameraAccess() {
    final _service = Get.find<RewardsService>();
    _service._allowCameraAccess();
  }

  static void allowLocationPermission() {
    final _service = Get.find<RewardsService>();
    _service._allowLocationPermission();
  }

  void _sharedApp() async {
    if (!sharedAppFlag) {
      try {
        final res = await _apiHelper.awardLoyaltyPoints('1000');
        final newBalance = res['data']['response']['pointsBalance'] as int;
        loyaltyController.updateCurrentBalance(newBalance);
        sharedAppFlag = true;
      } catch (e) {
        // TODO: Not sure how we would want to handle this error. A few retries until success?
        Log.error(e);
        return;
      }
    }
  }



  void _allowCameraAccess() async {
    if (!allowCameraAccessFlag) {
      try {
        final res = await _apiHelper.awardLoyaltyPoints('800');
        final newBalance = res['data']['response']['pointsBalance'] as int;
        loyaltyController.updateCurrentBalance(newBalance);
        allowCameraAccessFlag = true;
      } catch (e) {
        // TODO: Not sure how we would want to handle this error. A few retries until success?
        Log.error(e);
        return;
      }
    }
  }

  void _allowLocationPermission() async {
    if (!allowLocationPermissionFlag) {
      try {
        final res = await _apiHelper.awardLoyaltyPoints('900');
        final newBalance = res['data']['response']['pointsBalance'] as int;
        loyaltyController.updateCurrentBalance(newBalance);
        allowLocationPermissionFlag = true;
      } catch (e) {
        // TODO: Not sure how we would want to handle this error. A few retries until success?
        Log.error(e);
        return;
      }
    }
  }
}
