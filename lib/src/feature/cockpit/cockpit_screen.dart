import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/cockpit/common_widgets/navbar.dart';
import 'package:glorifi/src/feature/cockpit/controllers/cockpit_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/accounts_screen.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/products_screen.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_feed.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/today_feed.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/views/reward_landing_view.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CockpitScreen extends StatefulWidget {
  const CockpitScreen({Key? key}) : super(key: key);

  @override
  State<CockpitScreen> createState() => _CockpitScreenState();
}

class _CockpitScreenState extends State<CockpitScreen>
    with AutomaticKeepAliveClientMixin<CockpitScreen> {
  @override
  bool get wantKeepAlive => true;

  DataHelperImpl dataHelper = DataHelperImpl.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CockpitController get _cockpitController => Get.find<CockpitController>();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    dataHelper.cacheHelper.updateSkipValueScreen(true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (!sizingInfo.isNativeMobile) {
          return AdaptiveScaffoldWeb(hideWebAppBar: true).getScaffold(
            context: context,
            backgroundColor: GlorifiColors.red,
            // only show opacity when not todayFeed because PageView doesn't work well with extendBody
            body: TodayFeed(),
          );
        } else {
          return Obx(
            () => Scaffold(
              // only show opacity when not todayFeed because PageView doesn't work well with extendBody
              extendBody: !_cockpitController.isTabSelected(CockpitTab.today),
              bottomNavigationBar: !kIsWeb ? NavBar() : null,
              backgroundColor: Colors.white,
              body: _tabContent(),
            ),
          );
        }
      },
    );
  }

  TodayFeed? todayFeed;
  SnapshotFeed? snapshotFeed;
  RewardLandingView? rewardLandingView;
  AccountsScreen? accountsScreen;

  Widget _tabContent() {
    switch (_cockpitController.currentTab.value) {
      case CockpitTab.today:
        if (todayFeed == null) {
          todayFeed = TodayFeed();
        }
        return todayFeed!;
      case CockpitTab.snapshot:
        if (snapshotFeed == null) {
          snapshotFeed = SnapshotFeed();
        }
        return snapshotFeed!;
      case CockpitTab.accounts:
        if (accountsScreen == null) {
          accountsScreen = AccountsScreen();
        }
        return accountsScreen!;
      case CockpitTab.products:
        return ProductsScreen();
      case CockpitTab.rewards:
        if (rewardLandingView == null) {
          rewardLandingView = RewardLandingView();
        }
        return rewardLandingView!;
      default:
        return Container();
    }
  }
}
