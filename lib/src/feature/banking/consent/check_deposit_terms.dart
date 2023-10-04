import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import 'controller/check_deposit_controller.dart';

class CheckDepositTermsScreen extends GetView<CheckDepositController> {
  const CheckDepositTermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: GlorifiAppBar(
        title: 'Terms',
      ),
      body: Obx(
        () => Center(
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: controller.document!, zoomSteps: 1),
        ),
      ),
    );
  }
}
