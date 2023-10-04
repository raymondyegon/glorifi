import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/graph_with_curved_line_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:intl/intl.dart';
import '../widgets/carousel_card_top_part.dart';
import '../widgets/snapshot_carousel_card.dart';

class RetirementCard extends StatelessWidget {
  const RetirementCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshotController = Get.find<SnapshotController>();

    return GraphWithCurvedLineCard(
      title: "Total Retirement Fund",
      amount: NumberFormat.decimalPattern()
          .format(snapshotController.currentRetirement)
          .toString(),
      subtitle: r"Save $15,000/Year to hit your goal",
      subtitleColor: Color(0xFF1AD35E),
      routeName: Routes.savingsRetirementScreen,
    );
  }
}
