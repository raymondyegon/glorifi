import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/account_details_page_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/widgets/include_in_snapshot.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/widgets/account_history_graph_card.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/widgets/recent_activities_card.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/loading_shimmer.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/layout/layout.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class AccountDetailsPage extends GetView<AccountDetailsPageController> {
  final String institution;
  final String mask;
  final String accountId;
  final bool showGraph;

  AccountDetailsPage({
    Key? key,
    required this.institution,
    required this.mask,
    required this.accountId,
    this.showGraph = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(SavingsCheckingsController(type));
    Get.put(AccountDetailsPageController(accountId));

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return Layout(
          titleMobile: '',
          body: container(sizingInfo),
        );
      },
    );
  }

  Widget container(AdaptiveSizingInfo sizingInfo) {
    return controller.obx(
      (state) => controller.obx(
        (state) => ContentAccountDetails(
          institution: institution,
          mask: mask,
          showGraph: showGraph,
          controller: controller,
          sizingInfo: sizingInfo,
        ),
        onLoading: LoadingShimmer(),
        onEmpty: Text("Items Empty"),
        onError: (error) => Text("Server Error. Check Back Soon"),
      ),
    );
  }
}

class ContentAccountDetails extends StatelessWidget {
  const ContentAccountDetails({
    Key? key,
    required this.institution,
    required this.mask,
    required this.showGraph,
    required this.controller,
    required this.sizingInfo,
  }) : super(key: key);

  final String institution;
  final String mask;
  final bool showGraph;
  final AccountDetailsPageController controller;
  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF4F5F7),
      child: ListView(
        children: [
          containerResponsive(
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${institution} *${mask}',
                    style: TextStyle(
                      fontFamily: 'Univers',
                      color: Color(0xFF171A20),
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 24),
                  IncludeInSnapshotSelection(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      'Calculate how much you need to grow your wealth to ensure a smooth and hassle free post retirement life.',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (showGraph) AccountHistoryGraphCard(controller.graphData),
                  RecentActivities(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget containerResponsive(Widget child, {double? height}) {
    return Center(
      child: Container(
        width: sizingInfo.isDesktop ? 1024.w : double.maxFinite,
        height: height,
        child: child,
      ),
    );
  }
}
