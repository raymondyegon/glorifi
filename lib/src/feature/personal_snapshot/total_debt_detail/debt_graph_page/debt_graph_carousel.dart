import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/debt_graph_page/debt_graph.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/total_debt_controller.dart';
import 'package:glorifi/src/model/personal_snapshot/total_debt_detail_model.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class DebtGraphCarousel extends GetView<TotalDebtController> {
  DebtGraphCarousel(this.debtList);

  //TODO: change type
  final List<SingleDebtAccount> debtList;

  @override
  Widget build(BuildContext context) {
    List<Widget> _cards = [
      ...debtList.map(
        (item) {
          return DebtGraph(
            title: item.getLabel,
            graphData: [],
            interestRate: 0.045,
            approvedDebt: 10000,
            remainingDebt: 14200,
          );
        },
      )
    ];

    return Container(
      width: double.infinity,
      height: 450,
      child: PageView.builder(
        controller: PageController(
          initialPage: controller.carousalIndex.value,
          viewportFraction: 1,
        ),
        padEnds: false,
        scrollDirection: Axis.horizontal,
        itemCount: _cards.length,
        itemBuilder: (BuildContext context, int itemIndex) {
          return _cards[itemIndex];
        },
        onPageChanged: (int page) {
          controller.carousalIndex.value = page;
        },
      ),
    );
  }
}
