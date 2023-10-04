import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/model/profile_model.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class EditProfileCard extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final ProfileModel profileModel;

  const EditProfileCard({
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.profileModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          "COMPLETE YOUR PROFILE",
          style: bodyBold18Primary(color: GlorifiColors.midnightBlue),
        ),
        SizedBox(height: 24.h),
        Text(
          "Get more out of your GloriFi account by completing your profile.",
          style: smallRegular16Primary(color: GlorifiColors.midnightBlue),
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  child: LinearProgressIndicator(
                    minHeight: profileModel.totalProfileSteps.toDouble(),
                    value: profileModel.profileStepsComplete /
                        profileModel.totalProfileSteps,
                    color: GlorifiColors.biscayBlue,
                    backgroundColor: GlorifiColors.selectedIndicatorColor,
                  )),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
                "${profileModel.profileStepsComplete}/${profileModel.totalProfileSteps}")
          ],
        ),
      ],
    ).paddingSymmetric(vertical: 20.h, horizontal: 20.h);
  }
}
