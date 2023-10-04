import 'package:get/get.dart';

import 'package:glorifi/src/structure/base_controller.dart';

enum ButtonType { FRONT, BACK }

class DepositedCheckImagesController extends BaseController {
  dynamic image = Get.arguments;
  final activeButton = ButtonType.FRONT.obs;
}
