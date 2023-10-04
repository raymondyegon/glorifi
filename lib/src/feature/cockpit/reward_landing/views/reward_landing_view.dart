import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/profile_header.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/views/redeem_points_screen.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/widget/how_to_earn_point_widget.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/widget/point_earning_segment_list.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/widget/reward_point_widget.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/widget/rewards_partners.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/containers/cockpit_tab_screen.dart';

import '../controllers/reward_landing_controller.dart';

class RewardLandingView extends GetView<RewardLandingController> {
  RewardLandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RewardLandingController());

    _content(AdaptiveSizingInfo sizingInfo) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 19.h),
            if (sizingInfo.isNativeMobile) ProfileHeader(),
            Container(
              color: GlorifiColors.bgColor,
              child: Center(
                child: Container(
                  width: 1024,
                  child: RewardPointWidget(
                    landingController: controller,
                    onTapRedeem: _onTapRedeemButton,
                  ).paddingOnly(
                      left: sizingInfo.isDesktop ? 0 : 25.w,
                      right: sizingInfo.isDesktop ? 0 : 25.w,
                      top: 25.h,
                      bottom: 25.h),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 1072,
                child: RewardsPartners(),
              ),
            ),
            Obx(
              () => HowToEarnPointWidget(controller.earnPointFinancialAccount),
            ),
            Center(
              child: Container(
                width: 1024,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Earn Points Just for Simply Using the App.',
                      style: headlineRegular26Secondary(
                          color: GlorifiColors.darkBlue),
                    ).paddingOnly(
                        left: sizingInfo.isDesktop ? 0 : 25.w,
                        right: sizingInfo.isDesktop ? 0 : 25.w,
                        top: 36.h),
                    Obx(
                      () => PointEarningSegmentList(
                        controller.pointEarningSegmentList,
                      ).paddingSymmetric(
                          horizontal: sizingInfo.isDesktop ? 0 : 25.w),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 120.h)
          ],
        ),
      );
    }

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return sizingInfo.isNativeMobile
          ? CockpitTabScreen(
              onRefresh: () async => await controller.refreshPoints(),
              child: _content(sizingInfo),
            )
          : AdaptiveScaffold(body: _content(sizingInfo));
    });
  }

  void _onTapRedeemButton() async {
    // TODO: Show a spinner
    final url = await Get.find<LoyaltyController>().generateRewardLink();
    if (url != null) {
      Get.to(
        () => RedeemPointsScreen(
          redeemUrl: url,
        ),
      );
    } else {
      Log.error('Error generating rewards link');
      // TODO: Show an error that we are unable to send you to the rewards page
    }
  }
}
