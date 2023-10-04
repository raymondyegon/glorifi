import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/snapshot_carousel_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/personal_snapshot_section.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_header.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/profile_header.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/containers/cockpit_tab_screen.dart';

import '../../../../utils/glorifi_colors.dart';

class SnapshotFeed extends StatelessWidget {
  const SnapshotFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      Widget _nativeMobile() {
        return NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  color: GlorifiColors.productsBgWhite,
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 19.h),
                      ProfileHeader(),
                      SnapshotHeader(),
                      PersonalSnapshotSection(),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Insights(sizingInfo: sizingInfo),
        );
      }

      Widget _notNative() {
        return AdaptiveScaffold(
          backgroundColor: GlorifiColors.productsBgWhite,
          appBar: GlorifiAppBar(
            title: '',
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: sizingInfo.isDesktop
                  ? 200.w
                  : sizingInfo.isTablet
                  ? 34.5.w
                  : 24.w,
              vertical: 32.h,
            ),
            // width: 1024,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SnapshotHeader(),
                        PersonalSnapshotSection(),
                      ],
                    ),
                  ),
                ];
              },
              body: Insights(sizingInfo: sizingInfo),
            ),
          ),
        );
      }

      if (sizingInfo.isNativeMobile) {
        return CockpitTabScreen(
            child: _nativeMobile(),
            onRefresh: () async => await pullToRefresh());
      } else {
        return _notNative();
      }
    });
  }

  pullToRefresh() async {
    final snapshotController = Get.find<SnapshotController>();
    final snapshotCarouselController = Get.find<SnapshotCarouselController>();
    final insightsController = Get.find<InsightsController>();
    await snapshotCarouselController.pullToRefresh();
    await snapshotController.pullRefresh();
    await insightsController.pullToRefresh();
  }
}
