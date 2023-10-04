import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/success/success_screen.dart';

class UnlinkAccountSuccessScreen extends StatelessWidget {
  const UnlinkAccountSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountsCount = Get.arguments;

    return SuccessScreen(
      title: 'Your Account${accountsCount > 1 ? 's' : ''} ${accountsCount > 1 ? 'Were' : 'Was'} Unlinked!',
      buttonText: 'Close',
      appBarTitle: 'Account${accountsCount > 1 ? 's' : ''} Unlinked',
      onPressedButton: Get.back,
    );
  }
}
