import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class ACCFrozenScreen extends StatelessWidget {
  ACCFrozenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCExitContainer(
      isDarkMode: false,
      title: ACCScreensInfo.ACCFrozenScreen.title,
      subtitle: ACCScreensInfo.ACCFrozenScreen.subtitle!,
      ctaButtons: _buttons,
    );
  }

  final List<Widget> _buttons = [
    PrimaryDarkButton(
      title: TextConstants.continueApplication,
      onTap: () async {
        await Get.toNamed(Routes.accNotApprovedScreen);
      },
    ).marginOnly(bottom: 24.h),
    GlorifiOutlinedButton(
      title: TextConstants.resumeLater,
      borderColor: GlorifiColors.bloodOrange,
      onTap: () async {
        await Get.offNamedUntil(Routes.cockpit, (route) => false);
      },
    ),
  ];
}
