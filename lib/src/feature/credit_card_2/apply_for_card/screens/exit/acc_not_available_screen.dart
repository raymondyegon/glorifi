import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/controller/kyc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class ACCNotAvailableScreen extends GetView<KYCController> {
  const ACCNotAvailableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCExitContainer(
      title: controller.CCNotAvailableInSelectedStateTitle,
      subtitle: ACCScreensInfo.ACCCardNotAvailable.subtitle!,
      isDarkMode: false,
      ctaButtons: [
        PrimaryDarkButton(
          title: ACCScreensInfo.ACCCardNotAvailable.ctaTitle,
          onTap: () => Get.offNamedUntil(
            Routes.cockpit,
            ModalRoute.withName(Routes.devZone),
          ),
        ),
      ],
    );
  }
}
