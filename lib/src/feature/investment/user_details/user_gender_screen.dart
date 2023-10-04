import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/investment/widgets/common_method.dart';
import 'package:glorifi/src/feature/investment/widgets/selection_tile.dart';
import 'package:glorifi/src/feature/investment/widgets/submit_button_with_back.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';

class UserGenderScreen extends StatelessWidget {
  const UserGenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> genderList = ["Male", "Female", "Other"];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'What is your full, legal name?',
                style: textStyleHeading,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  CommonMethods().showHintSheet("Date of Birth",
                      "This is the reason we ask for date of birth. 18 and over, etc...");
                },
                child: Text(
                  "Why we need this",
                  style: textStyleSubHeading,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: genderList.length,
                    itemBuilder: (context, index) {
                      return SelectionTile(title: genderList[index]);
                    }),
              ),
              SubmitButtonWithBack(buttonText: "Next", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
