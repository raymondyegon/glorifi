import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class CheckViewReviewActionsScreen extends StatelessWidget {
  CheckViewReviewActionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        appBar: GlorifiAppBar(
          title: 'My Banking',
          trailing: Trailing(
            text: "Close",
            onTap: Get.back,
            textStyle: captionBold14Primary(color: GlorifiColors.bloodOrange),
          ),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.depositedChecks),
              child: const Text("Deposited checks")),
        ));
  }
}
