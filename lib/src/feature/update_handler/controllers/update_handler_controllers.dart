import 'dart:io';
import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/login/models/login_args.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateHandlerControllers extends BaseController {
  UpdateTerms updateTerms = UpdateTerms.updated;

  @override
  void onInit() async {
    final loginArgs = Get.arguments as LoginArgs;
    updateTerms = loginArgs.updateTerms;
    super.onInit();
  }
}
