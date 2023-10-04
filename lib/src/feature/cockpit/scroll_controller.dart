import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ScrollingController extends GetxController {
  var minChild = 0.2.obs;
  var maxChild = 0.85.obs;
  var navVisible = false.obs;
}
