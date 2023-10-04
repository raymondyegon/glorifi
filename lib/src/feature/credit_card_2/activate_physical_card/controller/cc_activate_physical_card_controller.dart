import 'package:get/get.dart';

class CCActivatePhysicalCardController extends GetxController {
  var digit = "".obs;
  var enableButton = false.obs;
  var cardActivationSuccess = false.obs;

  validate(String value) {
    digit.value = value;
    shouldEnableButton();
    // TODO: Check card activation status
    cardActivationSuccess.value =
        true; // TODO: Set value to true when service returns success
  }

  shouldEnableButton() {
    digit.value.length == 4
        ? enableButton.value = true
        : enableButton.value = false;
  }
}
