import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_rule_ui_model.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_segment_ui_model.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import 'item_point_earning_category.dart';

class PointEarningSegmentList extends StatelessWidget {
  late final List<PointEarningSegmentUiModel> segmentList;
  final Function(PointEarningRuleUiModel model)? onTap;

  PointEarningSegmentList(this.segmentList, {this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.isNativeMobile || sizingInfo.isWebMobile) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: segmentList.length,
          itemBuilder: (context, index) {
            var segmentModel = segmentList[index];
            return ItemPointEarningCategory(model: segmentModel, onTap: onTap)
                .marginSymmetric(vertical: 5.h);
          },
        );
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: segmentList.map((e) {
            return Expanded(
                child: ItemPointEarningCategory(model: e, onTap: onTap)
                    .marginSymmetric(vertical: 5.h)
                    .paddingOnly(right: 32));
          }).toList(),
        );
      }
    });
  }
}
