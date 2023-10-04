import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class ACCSSNErrorFeedbackScreen extends StatelessWidget {
  const ACCSSNErrorFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ACCScreenInfoModel accVerifySSNError = ACCScreensInfo.ACCVerifySSNError;

    return ACCExitContainer(
      title: accVerifySSNError.title,
      subtitle: accVerifySSNError.subtitle!,
      isDarkMode: false,
      ctaButtons: [
        PrimaryDarkButton(
          title: accVerifySSNError.ctaTitle,
          width: 1.sw,
          onTap: () => Get.offNamedUntil(
            Routes.cockpit,
            ModalRoute.withName(Routes.devZone),
          ),
        ),
      ],
    );
  }
}
