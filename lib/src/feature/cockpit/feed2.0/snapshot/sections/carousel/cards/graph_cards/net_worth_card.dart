import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/graph_with_curved_line_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:intl/intl.dart';

class NetWorthCard extends StatelessWidget {
  const NetWorthCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshotController = Get.find<SnapshotController>();

    return GraphWithCurvedLineCard(
      title: "Net Worth",
      amount: NumberFormat.decimalPattern()
          .format(snapshotController.currentNetWorth)
          .toString(),
      subtitle: r"$9K higher than yesterday",
      subtitleColor: Color(0xFF1AD35E),
      routeName: Routes.netWorthDetailScreen,
    );
  }
}
