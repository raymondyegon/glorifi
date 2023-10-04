import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/analytics.dart';
import 'package:glorifi/src/feature/cockpit/controllers/cockpit_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  final featureFlagController = Get.find<FeatureFlagController>();

  @override
  Widget build(BuildContext context) {
    var _cockpitController = Get.find<CockpitController>();
    StoryController _storyController = Get.find<StoryController>();

    Widget _item({
      required CockpitTab tab,
      label,
      asset,
      analytics,
    }) {
      return InkWell(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: _cockpitController.isTabSelected(tab)
                    ? GlorifiColors.blueFocusedItem
                    : GlorifiColors.white,
                width: 2.h,
              ),
            ),
            color: _cockpitController.isTabSelected(tab)
                ? GlorifiColors.lightBlueBg
                : GlorifiColors.white,
          ),
          width: 0.24.sw,
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
          ),
          child: Column(
            children: [
              Obx(
                () => SvgPicture.asset(
                  "$asset",
                  color: _cockpitController.isTabSelected(tab)
                      ? GlorifiColors.blueIcon
                      : GlorifiColors.textDarkBlue,
                  height: 18.sp,
                  width: 18.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                label,
                style: tinyBold10Primary(
                  color: _cockpitController.isTabSelected(tab)
                      ? GlorifiColors.blueIcon
                      : GlorifiColors.textDarkBlue,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          if (tab == CockpitTab.today) {
            _storyController.refreshStories();
          }
          _cockpitController.currentTab(tab);
        },
      );
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: SizedBox(
          height: 80.h,
          child: Container(
            color: GlorifiColors.white,
            alignment: Alignment.center,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _item(
                    tab: CockpitTab.today,
                    asset: GlorifiAssets.calendarInActive,
                    label: TextConstants.today,
                    analytics: TextConstants.todayChoose,
                  ),
                  _item(
                    tab: CockpitTab.snapshot,
                    asset: GlorifiAssets.snapshotsInActive,
                    label: TextConstants.snapshot,
                    analytics: TextConstants.snapShotsChoose,
                  ),
                  if (featureFlagController.showProductsTab.value == true)
                    _item(
                      tab: CockpitTab.products,
                      asset: GlorifiAssets.accounts,
                      label: TextConstants.products,
                      analytics: TextConstants.accountsChoose,
                    ),
                  if (featureFlagController.showProductsTab.value == false)
                    _item(
                      tab: CockpitTab.accounts,
                      asset: GlorifiAssets.accounts,
                      label: TextConstants.accounts,
                      analytics: TextConstants.accountsChoose,
                    ),
                  _item(
                    tab: CockpitTab.rewards,
                    asset: GlorifiAssets.rewardsInActive,
                    label: TextConstants.rewards,
                    analytics: TextConstants.rewardsChoose,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
