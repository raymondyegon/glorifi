import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/video_modal.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_logos.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/glorifi_logos/glorifi_logos.dart';

class GlorifiStory extends GetView<StoryController> {
  final bool isFirstStory;
  final StoryModel story;

  const GlorifiStory({Key? key, required this.isFirstStory, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      var backgroundImageURL;
      var backgroundImageAsset;

      if (sizingInfo.isDesktop || sizingInfo.isTablet) {
        backgroundImageAsset = "assets/images/glorify_story.png";
      } else {
        backgroundImageURL = story.backgroundImage;
      }

      return BaseStory(
          modal: VideoModal(isYouTube: false),
          onTap: () {
            controller.videoController.play();
          },
          playButton: true,
          backgroundImageURL: backgroundImageURL,
          backgroundImageAsset: backgroundImageAsset,
          isFirstStory: isFirstStory,
          child: Container(
            height: 1.sh,
            padding: EdgeInsets.symmetric(
                horizontal: sizingInfo.isDesktop || sizingInfo.isTablet ? 90.w : 45.w,
                vertical: sizingInfo.isDesktop || sizingInfo.isTablet ? 100.h : 52.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    GloriFiLogos(
                      imageKey: GlorifiLogos.logoBrandMarkWhite,
                      width: 27.w,
                      height: 9.h,
                    ),
                    SizedBox(width: 5),
                    Text("Today",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("The GloriFi Story: Freedom. Independence. Technology.",
                    style: TextStyle(
                        color: GlorifiColors.white,
                        fontSize: sizingInfo.isDesktop || sizingInfo.isTablet ? 48 : 21,
                        height: 1.4,
                        fontFamily: 'univers'))
              ],
            ),
          ));
    });
  }
}
