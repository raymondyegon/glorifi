import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/on_boarding_controller.dart';

class OnBoardingButtons extends GetView<OnBoardingController> {
  const OnBoardingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35, left: 25, right: 25),
      child: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Create an Account'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 25),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                onPressed: () {},
                child: const Text('Sign-in'),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.navigateToProducts();
              },
              child: const Text(
                'See all Glorifi Products',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.transparent,
                  fontSize: 12,
                  fontFamily: 'univers',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
