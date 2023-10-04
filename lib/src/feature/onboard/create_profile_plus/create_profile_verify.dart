import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/create_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/create_profile_secure.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/create_profile_verfication_failed.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/verified_widget.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/verifying_info_widget.dart';
import 'package:glorifi/src/widgets/containers/gradient_overlay_container.dart';

class CreateProfileVerify extends StatefulWidget {
  CreateProfileVerify({Key? key}) : super(key: key);

  @override
  _CreateProfileVerify createState() => _CreateProfileVerify();
}

class _CreateProfileVerify extends State<CreateProfileVerify> {
  CreateProfileController get controller => Get.find<CreateProfileController>();

  @override
  void initState() {
    listenToVerifyMemberStream();
    super.initState();
  }

  listenToVerifyMemberStream() {
    controller.verifyMemberStream.listen((status) {
      switch (status) {
        case VerifyMember.accepted: _moveToSecureProfilePage();
          break;
        case VerifyMember.denied: _moveToErrorPage();
          break;
        default:{}
      }
    });
  }

  _moveToSecureProfilePage() async {
    await Future.delayed(Duration(seconds: 3));
    Get.off(() => CreateProfileSecure());
  }

  _moveToErrorPage() {
    Get.off(() => CreateProfileVerificationFailed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: Stack(
          children: [
            Positioned.fill(
              child: GradientOverlayContainer(
                colors: [
                  Color(0x9A03213D),
                  Color(0xA603213D),
                  Color(0xFF03213D)
                ],
                stops: [0.2, 0.3, 0.8],
                child: Image.asset(
                  'assets/images/login_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Obx(() => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: getPageContent(),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget getPageContent() {
    switch (controller.verifyMemberStatus.value) {
      case VerifyMember.accepted:
        return VerifiedWidget();
      default:
        return VerifyingInformationWidget(
          name: controller.greetingsName,
        );
    }
  }
}
