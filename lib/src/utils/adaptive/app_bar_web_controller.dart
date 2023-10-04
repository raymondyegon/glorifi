import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/login_status/login_status.dart';

class GlobalAppBarWebController extends BaseController {
  late RxString _firstName;
  late RxString _lastName;
  late RxString _twoLettersOfName;

  ProfileController get profileController => Get.find<ProfileController>();
  final SessionManagerService _sessionManagerService =
      Get.find<SessionManagerService>();

  LoyaltyController get loyaltyController => Get.put(LoyaltyController());

  Rx<bool> loggedIn = false.obs;

  RxString get userInitials => _twoLettersOfName;

  GlobalAppBarWebController() {
    _firstName = profileController.userProfile.firstName.obs;
    _lastName = profileController.userProfile.lastName.obs;
    _twoLettersOfName = "${_firstName.isNotEmpty ? _firstName.value[0] : ''} "
            "${_lastName.isNotEmpty ? _lastName.value[0] : ''}"
        .obs;
  }

  @override
  void onInit() async {
    await isUserLoggedIn();
    super.onInit();
  }

  Future<bool> isUserLoggedIn() async {
    return CheckLoginStatus.isLoggedIn().then((value) {
      loggedIn.value = value;
      return Future.value(value);
    });
  }
}
