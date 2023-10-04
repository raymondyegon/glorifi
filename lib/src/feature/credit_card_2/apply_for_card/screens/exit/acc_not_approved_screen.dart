import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class ACCNotApprovedScreen extends StatelessWidget {
  const ACCNotApprovedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCExitContainer(
      title: ACCScreensInfo.ACCNotApprovedScreen.title,
      subtitle: ACCScreensInfo.ACCNotApprovedScreen.subtitle!,
      isDarkMode: false,
      ctaButtons: [
        PrimaryDarkButton(
          title: ACCScreensInfo.ACCNotApprovedScreen.ctaTitle,
          onTap: () async {
            await Get.offNamedUntil(Routes.cockpit, (route)=> false);
          },
        ),
      ],
    );
  }
}
