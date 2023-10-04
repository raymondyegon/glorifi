import 'package:get/get.dart';

class ExpandableTileController extends GetxController {
  var isExpanded = false.obs;

  void toggle() {
    isExpanded.toggle();
  }
}
