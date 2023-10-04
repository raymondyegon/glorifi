import 'package:get/get.dart';
import 'package:glorifi/src/controllers/snapshot_data_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/model/account_flags_model.dart';

class AccountFlagsController extends GetxController {
  final SnapshotDataController _snapshotDataController =
      Get.put(SnapshotDataController());

  RxBool isLoading = false.obs;
  RxBool error = false.obs;

  ///data were already loaded at least once
  RxBool didLoad = false.obs;

  Rx<AccountFlagsModel> flags = AccountFlagsModel().obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  Future<void> loadData({bool showLoading = true}) async {
    try {
      if (showLoading) {
        isLoading.value = true;
      }
      final result = await _snapshotDataController.getLinkDataFlowData();
      if (result is AccountFlagsModel) {
        flags.value = result;
        error.value = false;
        didLoad.value = true;
      }
    } catch (e) {
      error.value = true;
      isLoading.value = false;
      Log.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
