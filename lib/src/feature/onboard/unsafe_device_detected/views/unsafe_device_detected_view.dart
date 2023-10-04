import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../controllers/unsafe_device_detected_controller.dart';

class UnsafeDeviceDetectedView extends GetView<UnsafeDeviceDetectedController> {
  const UnsafeDeviceDetectedView({Key? key}) : super(key: key);

  String get unsafeType => Platform.isIOS ? "Jailbroken" : "Rooted";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$unsafeType Device Detected",
                style: headlineRegular31Secondary(
                  color: GlorifiColors.midnightBlue,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Your account information is not safe on this device.",
                style: bodyBold18Primary(color: GlorifiColors.midnightBlue),
                textAlign: TextAlign.center,
              ).marginOnly(top: 24),
              Text(
                "We take data security seriously, GloriFi can not be run on this device.",
                style: smallRegular16Primary(color: GlorifiColors.midnightBlue),
                textAlign: TextAlign.center,
              ).marginOnly(top: 16),
              PrimaryButton(
                title: "Got it",
                primaryColor: GlorifiColors.midnightBlue,
                textColor: GlorifiColors.white,
                onTap: SystemNavigator.pop,
              ).marginOnly(top: 56)
            ],
          ),
        ),
      ).paddingAll(24),
    );
  }
}
