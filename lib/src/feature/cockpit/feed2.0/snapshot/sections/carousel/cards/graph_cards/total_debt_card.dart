import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/graph_with_curved_line_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:intl/intl.dart';

class TotalDebtCard extends StatelessWidget {
  const TotalDebtCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshotController = Get.find<SnapshotController>();

    return GraphWithCurvedLineCard(
      title: "Total Debt",
      amount: NumberFormat.decimalPattern()
          .format(snapshotController.currentDebt.abs())
          .toString(),
      subtitle: r"$9K Balance Increase",
      subtitleColor: Color(0xFFFA3E3E),
      routeName: Routes.totalDebtDetailScreen,
    );
  }
}
