import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/controllers/cockpit_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/app_button.dart';

class LastStory extends StatelessWidget {
  final LastStoryModel story;

  const LastStory({Key? key, required LastStoryModel this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return Container(
          color: GlorifiColors.productsBgWhite,
          padding: EdgeInsets.symmetric(
            vertical: 75.0.h,
            horizontal: 25.0.w,
          ),
          alignment: Alignment.bottomCenter,
          child: AdaptiveGrid(gridSpacing: sizingInfo.isDesktop || sizingInfo.isTablet ? 80 : 0, children: [
            AdaptiveGridItem(
                desktop: 50,
                child: Text(
              story.message,
                  style: headlineRegular26Secondary(color: GlorifiColors.darkBlueColor),
                )),
            if (sizingInfo.isWebMobile || sizingInfo.isNativeMobile)
              AdaptiveGridItem(
                child: SizedBox(height: 150.h),
              ),
            AdaptiveGridItem(
                desktop: 50,
                child: AppButton(
                  onTap: () {
                    CockpitController cockpitController = Get.find();
                    cockpitController.onTabSelected(CockpitTab.snapshot);
                  },
                  label: 'View Snapshot',
                  backgroundColor: GlorifiColors.darkBlueColor,
                  textColor: GlorifiColors.white,
                ))
          ]));
    });
  }
}
