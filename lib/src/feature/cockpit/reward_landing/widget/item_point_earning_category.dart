import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_rule_ui_model.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_segment_ui_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import 'item_point_earning_action.dart';

class ItemPointEarningCategory extends StatelessWidget {
  final PointEarningSegmentUiModel model;
  final Function(PointEarningRuleUiModel model)? onTap;

  const ItemPointEarningCategory({
    required this.model,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(
          model.title,
          style: bodySemiBold18Primary(color: GlorifiColors.darkBlue),
        ),
        SizedBox(height: 32.h),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.pointEarningRuleList.length,
          itemBuilder: (context, index) {
            var ruleModel = model.pointEarningRuleList[index];

            return Column(
              children: [
                Divider(
                  thickness: 1.h,
                  color: GlorifiColors.silver,
                ),
                ItemPointEarningAction(
                  model: ruleModel,
                  onTap: onTap,
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
