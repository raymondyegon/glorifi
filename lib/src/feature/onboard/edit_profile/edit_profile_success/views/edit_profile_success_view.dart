import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../controllers/edit_profile_success_controller.dart';

class EditProfileSuccessView extends GetView<EditProfileSuccessController> {
  const EditProfileSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: GlorifiColors.midnightBlue,
        appBar: GlorifiAppBar(
          title: controller.title,
          leading: Leading(
            onTap: () {
              Get.back(result: true);
            },
            icon: SvgPicture.asset("assets/images/ic_close.svg"),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/ic_check.svg"),
            SizedBox(height: 45.h),
            Text(
              controller.message,
              style: headlineRegular31Secondary(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onWillPop: () {
        // Get.back();
        Get.back(result: true);
        return Future.value(false);
      },
    );
  }
}
