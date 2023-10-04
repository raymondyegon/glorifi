import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/feature/legal/views/legal_screen.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:lottie/lottie.dart';

class LegalRequestSuccess extends StatelessWidget {
  const LegalRequestSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.darkMidnightBlue,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(children: [
            SizedBox(height: 100.h),
            Lottie.asset(
              'assets/json/complete.json',
              width: 200.h,
              repeat: false,
            ),
            Text(
              'Thank you for your request',
              style: leadBold24Primary(color: GlorifiColors.white),
            ).paddingOnly(bottom: 48.h),
            Text(
              'Your request is being processed and we will get back to you as soon as possible',
              style: smallRegular16Primary(color: GlorifiColors.white),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            PrimaryButton(
              title: 'Done',
              onTap: () {
                Get.back();
                Get.back();
              },
            )
          ]),
        ),
      ),
    );
  }
}
