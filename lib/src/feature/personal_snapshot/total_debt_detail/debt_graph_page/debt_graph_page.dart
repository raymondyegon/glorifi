import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/loading_shimmer.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/debt_graph_page/debt_graph.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/debt_graph_page/debt_graph_carousel.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/debt_graph_page/debt_graph_legends.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/total_debt_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/carousel_indicator.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/link_new_account_button.dart';
import 'package:glorifi/src/model/personal_snapshot/total_debt_detail_model.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class DebtGraphPage extends GetView<TotalDebtController> {
  DebtGraphPage({Key? key, required this.title, required this.debtList})
      : super(key: key);

  final String title;
  final List<SingleDebtAccount> debtList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: '${debtList.length} ${title}',
        textStyle: TextStyle(
          fontFamily: "Univers",
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: Color(0xFF171A20),
        ),
        leadingIconDefaultColor: Color(0xFF171A20),
        elevation: 0,
        bgColor: Color(0xFFF4F5F7),
      ),
      body: Container(
        color: Color(0xFFF4F5F7),
        child: ListView(
          children: [
            SizedBox(height: 50),
            DebtGraphCarousel(debtList),
            Obx(
              () => CarousalIndicator(
                dotsCount: debtList.length,
                position: controller.carousalIndex.value,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: LinkNewAccountButton(),
            ),
          ],
        ),
      ),
    );
  }
}
