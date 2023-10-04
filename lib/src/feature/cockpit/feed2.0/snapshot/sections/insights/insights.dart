import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_linked_account.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_shimmer.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/no_linked_account.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';

class Insights extends StatelessWidget {
  Insights({Key? key, required this.sizingInfo}) : super(key: key);

  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {  
    final insightsController = Get.put(InsightsController());

    return
        // Wrap(
        //   children: [
        Obx(
      () {
        if (insightsController.accountFlagsController.didLoad.value == false) {
          return InsightsShimmer();
        }

        return insightsController
                    .accountFlagsController.flags.value.hasPlaidLinkedAcct ==
                false
            ? NoLinkedAccount()
            : InsightsLinkedAccount(sizingInfo: sizingInfo);
      },
      // ),
      // ],
    );
  }
}
