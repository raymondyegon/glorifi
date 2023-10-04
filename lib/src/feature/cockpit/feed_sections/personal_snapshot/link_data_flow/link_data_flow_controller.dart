import 'package:get/get.dart';
import 'package:glorifi/src/controllers/account_flags_controller.dart';
import 'package:glorifi/src/controllers/home_value_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/success_address_screen.dart';
import 'package:glorifi/src/routes/app_pages.dart';

class LinkDataFlowController extends GetxController {
  final homeValueController = Get.put(HomeValueController());

  final AccountFlagsController accountFlagsController =
      Get.put(AccountFlagsController());

  void goToHomeAddress(AddressFlowType flowType) {
    homeValueController.goToAddressScreen(flowType);
  }

  void goToHomeDetailsScreen() {
    homeValueController.goToDetailsScreen();
  }

  void creditScore() {
    Get.toNamed(Routes.enableCreditScoreStep1Name);
  }

  String address() {
    final String street = homeValueController.streetAddress.value;
    final String city = homeValueController.cityState.value;
    final bool validInfo = street.isNotEmpty || city.isNotEmpty;

    return validInfo ? '${street.trim()}\n${city.trim()}' : '';
  }
}
