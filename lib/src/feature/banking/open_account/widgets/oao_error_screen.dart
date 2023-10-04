import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/errors/widget/error_404_widget.dart';
import 'package:glorifi/src/routes/app_pages.dart';

class OAOErrorScreen extends StatelessWidget {
  const OAOErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OAOController>();
    return Scaffold(body: Error404Widget(
      onTap: () async {
        controller.loading.value = false;
        await Get.offAllNamed(Routes.cockpit);
      },
    ));
  }
}
