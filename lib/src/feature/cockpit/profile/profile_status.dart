import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../font_style_global.dart';

class ProfileStatus extends GetView<ProfileController> {
  const ProfileStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.editProfileLanding);
      },
      child: Container(
        height: 211.h,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Complete Your Profile".toUpperCase(),
              style: smallBold16Secondary(),
            ),
            Text(
              "Get more out of your GloriFi account by completing your profile. ",
              style: smallRegular16Primary(),
            ),
            Obx(
              () {
                return Row(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 5,
                        valueIndicatorTextStyle: TextStyle(color: Colors.black),
                        thumbColor: Colors.transparent,
                        thumbShape: SliderComponentShape.noThumb,
                      ),
                      child: SizedBox(
                        width: 275.w,
                        child: Slider(
                          onChanged: (double value) {},
                          value: controller.profileStepsComplete /
                              controller.profileStepsTotal,
                          activeColor: GlorifiColors.darkBlue,
                        ),
                      ),
                    ),
                    Text(
                        "${controller.profileStepsComplete}/${controller.profileStepsTotal}",
                        style: TextStyle(fontSize: 14.sp)),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
