import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/sections/top/retirement_doughnut.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/widgets/charts/chart_key.dart';

class RetirementDoughnutContainer extends StatelessWidget {
  const RetirementDoughnutContainer({Key? key, required this.sizingInfo}) : super(key: key);
  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RetirementController>();

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GraphKey(
            quantity: controller.employerSponsoredTotal.value,
            label: 'Employer-sponsored',
            color: const Color(0xFFC2D1EF),
          ),
          SizedBox(width: 60),
          GraphKey(
            quantity: controller.individualTotal.value,
            label: 'Individual retirement',
            color: const Color(0xFF6490E8),
          )
        ]),
        Container(
          width: sizingInfo.isDesktop ? 795 : double.maxFinite,
          child: RetirementDoughnut(
            value1: controller.employerSponsoredTotal.value,
            value2: controller.individualTotal.value,
          ),
        ),
      ],
    );
  }
}
