import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class ACCApplicationInReviewScreen extends StatelessWidget {
  const ACCApplicationInReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCExitContainer(
      title:
      "Your application is in review, Please check back again later.",
      ctaButtons: [
        PrimaryButton(
          title: "Close",
          onTap: () async {
            await Get.offNamedUntil(Routes.cockpit, (route) => false);
          },
        )
      ],
    );
  }
}
