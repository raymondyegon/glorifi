import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';

class CommunicationsController extends GetxController {

  final _glorifiMessageSwitchController = true.obs;
  bool get glorifiMessageStatus => _glorifiMessageSwitchController.value;

  void toggleGlorifiMessage() {
    _glorifiMessageSwitchController(!_glorifiMessageSwitchController.value);
    // TODO: Store this boolean value into SharedPreference
    Log.debug("Switch enable: $glorifiMessageStatus");
  }
}
