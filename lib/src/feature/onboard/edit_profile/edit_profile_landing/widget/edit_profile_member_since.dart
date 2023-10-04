import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class EditProfileMemberSince extends GetView<ProfileController> {
  const EditProfileMemberSince({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // controller
        //     .obx(
        //       (data) => Text(
        //         controller.userModel.nameFirst
        //                 .toString() +
        //             " " +
        //             controller.userModel.nameLast
        //                 .toString(),
        //         style: TextStyle(
        //             color: GlorifiColors.midnightBlue,
        //             fontFamily: 'univers',
        //             fontSize: 20),
        //       ),
        //       onLoading: Text(""),
        //     )
        //     .paddingOnly(bottom: 5),
        controller
            .obx(
                (data) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profileBodyText("Member since ",
                            color: GlorifiColors.midnightBlue),
                        editProfileTitleText(
                          controller.getJoinedDate(),
                          color: GlorifiColors.midnightBlue,
                        ),
                      ],
                    ),
                onLoading: Offstage())
            .paddingOnly(top: 20),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileBodyText("Member number:  ",
                  color: GlorifiColors.midnightBlue),
              editProfileTitleText(
                controller.userProfile.memberId ?? "None",
                color: GlorifiColors.midnightBlue,
              ),
            ],
          ).paddingOnly(top: 5),
        ),
      ],
    ).paddingOnly(left: 15);
  }
}
