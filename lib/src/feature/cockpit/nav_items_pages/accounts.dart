import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/nav_items_pages/insights.dart';
import 'package:glorifi/src/feature/cockpit/common_widgets/onboarding_button.dart';

class AccountsPage extends StatelessWidget {
  final amount = TextEditingController();

  AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              const Text("Please enter amount"),
              CustomWidgets()
                  .textField(amount, TextInputType.number, "Enter Email"),
              CustomWidgets().onBoardButton("Next", () {
                Get.to(() => InsightsPage(), arguments: amount.text);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
