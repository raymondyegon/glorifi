import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';

class ProfileErrorHandleController extends GetxController {
  var isLoading = false.obs;

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await DataHelperImpl.instance.apiHelper.getUserProfile();
      response.fold(
        print,
        (success) async {
          Get.back(result: success);
        },
      );
    } catch (e) {
      Log.error("Error from profile controller: ${e.toString()}");
    } finally {
      // hide loader
      isLoading.value = false;
    }
  }
}
