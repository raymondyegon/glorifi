import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class ACCResumeApplicationScreen extends StatelessWidget {
  const ACCResumeApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCExitContainer(
      title: "You already have an application in progress.",
      ctaButtons: [
        PrimaryButton(
          title: "Resume",
          hasRightArrow: true,
          onTap: () async {
            Get.offNamed(Get.arguments);
          },
        ),
        SizedBox(height: 20),
        GlorifiOutlinedButton(
          title: "Not Now",
          primaryColor: GlorifiColors.blueMidnightBlue,
          borderColor: GlorifiColors.white,
          textColor: GlorifiColors.white,
          onTap: () async {
            await Get.offNamedUntil(Routes.cockpit, (route) => false);
          },
        )
      ],
    );
  }
}
