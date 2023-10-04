// ignore_for_file: unnecessary_lambdas

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/widgets/text_style.dart';

class ProfileContainer extends StatelessWidget {
  final int stepNumber;
  final int maxSteps = 6;
  final String title;
  final String? subtitle;
  final Widget child;
  final bool showBack;
  final Function onNext;
  final String? nextTitle;
  final bool showNext;
  const ProfileContainer(
      {Key? key,
      required this.stepNumber,
      required this.title,
      this.subtitle,
      required this.child,
      required this.showBack,
      required this.onNext,
      this.showNext = true,
      this.nextTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            if (stepNumber > 0) Text('$stepNumber/$maxSteps'),
            Text(
              title,
              style: onboardingTitleStyle(),
            ),
            if (subtitle != null) Text(subtitle!),
            child,
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (showBack)
                  IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.chevron_left)),
                if (showBack) const Spacer(),
                if (showNext)
                  ElevatedButton(
                    onPressed: () => onNext(),
                    child: Text(nextTitle ?? 'Next'),
                  )
              ],
            )
          ],
        ).paddingAll(30),
      ),
    );
  }
}
