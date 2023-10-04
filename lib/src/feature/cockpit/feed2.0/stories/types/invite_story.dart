import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/share/share_app_util.dart';

import '../../../../../font_style_global.dart';
import '../../../../../utils/glorifi_colors.dart';
import '../../../../../utils/glorifi_logos.dart';
import '../../../../../widgets/buttons/primary_button.dart';
import '../../../../../widgets/glorifi_logos/glorifi_logos.dart';

class InviteStory extends StatelessWidget {
  final StoryModel story;

  const InviteStory({Key? key, required StoryModel this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStory(
      child: Stack(
        children: [
          Image.asset(
            GlorifiAssets.splashImage4,
            fit: BoxFit.cover,
            width: 1.sw,
          ),
          Image.asset(
            GlorifiAssets.gradientInvite,
            fit: BoxFit.fill,
            width: 1.sw,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 80.h),
                  child: GloriFiLogos(
                      imageKey: GlorifiLogos.logoDarkBg,
                      height: 76.h,
                      width: 172.w),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 64.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invite a Friend",
                        style: headlineRegular31Secondary(
                          color: GlorifiColors.lightBlue40,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "Invite your friends to download the GloriFI financial wellness app.",
                        style: captionRegular14Secondary(
                            color: GlorifiColors.white),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      PrimaryButton(
                        height: 64.h,
                        title: 'Get Started',
                        hasRightArrow: true,
                        onTap: share,
                        width: Get.width,
                        primaryColor: GlorifiColors.white,
                        textColor: GlorifiColors.midnightBlueColor,
                        splashColor: GlorifiColors.midnightBlueColor,
                        fontSize: 18.sp,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> share() async {
    await ShareAppUtil.showShareApp(null, null, null);
  }
}
