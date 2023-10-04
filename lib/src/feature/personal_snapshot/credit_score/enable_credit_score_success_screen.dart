import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/event_broadcaster.dart';
import 'package:glorifi/src/feature/success/success_screen.dart';

class EnableCreditScoreSuccessScreen extends StatelessWidget {
  EnableCreditScoreSuccessScreen({Key? key}) : super(key: key);

  ///dynamic link to show this screen
  ///https://glorifi.page.link/NLtk

  @override
  Widget build(BuildContext context) {
    return SuccessScreen(
      appBarTitle: 'Verify Identity',
      title: 'Your Credit Score Was Added!',
      buttonText: 'Done',
      centerTitle: false,
      onPressedButton: () {
        EventBroadcaster.instance.addEvent(CreditScoreWasEnabledEvent());
        Get.back;
      },
    );
  }
}
