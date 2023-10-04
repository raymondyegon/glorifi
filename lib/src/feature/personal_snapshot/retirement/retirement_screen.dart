import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/loading_shimmer.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/sections/top/retirement_doughnut_container.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/sections/top/total_fund_container.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/dropdown_widgets/snapshot_dropdown.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/layout/layout.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/link_new_account_button.dart';
import 'package:intl/intl.dart';

class RetirementScreen extends GetView<RetirementController> {
  const RetirementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return Layout(
          titleMobile: "Retirement",
          body: controller.obx(
            (state) => ContentRetirement(
              children: [
                sizingInfo.isDesktop ? titleDesktop("Retirement") : SizedBox(),
                Container(
                  color: GlorifiColors.blackBlue,
                  child: Column(
                    children: [
                      SizedBox(height: 46.h),
                      containerDesktop(
                        TopCarouselWithGraphs(sizingInfo),
                        sizingInfo: sizingInfo,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sizingInfo.isDesktop ? 54 : 0),
                containerDesktop(
                  Dropdowns(controller),
                  sizingInfo: sizingInfo,
                ),
                containerDesktop(
                  Time(),
                  sizingInfo: sizingInfo,
                ),
              ],
            ),
            onLoading: LoadingShimmer(),
            onEmpty: Text("Items Empty"),
            onError: (error) => Text("Check Back Soon"),
          ),
        );
      },
    );
  }
}

Widget Time() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      'As of ${DateFormat('MMM dd').format(DateTime.now())} (updates everyday)',
      textAlign: TextAlign.center,
    ),
  );
}

Widget Dropdowns(RetirementController controller) {
  return Column(
    children: [
      SnapshotDropdown(
        name: "Employer-Sponsored Accounts",
        dropdownItems: makeDropdownItems(controller.employerSponsoredAccounts),
        additionalWidget: LinkNewAccountButton(),
      ),
      SnapshotDropdown(
        name: "Individual Retirement Accounts",
        dropdownItems:
            makeDropdownItems(controller.individualSponsoredAccounts),
        additionalWidget: LinkNewAccountButton(),
      ),
    ],
  );
}

Widget TopCarouselWithGraphs(AdaptiveSizingInfo sizingInfo) {
  return Container(
    color: GlorifiColors.blackBlue,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Total amount across all connected retirement funds.',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        TotalFundContainer(),
        RetirementDoughnutContainer(sizingInfo: sizingInfo),
      ],
    ),
  );
}

class ContentRetirement extends StatelessWidget {
  const ContentRetirement({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlorifiColors.bgColor,
      child: ListView(
        children: children,
      ),
    );
  }
}
