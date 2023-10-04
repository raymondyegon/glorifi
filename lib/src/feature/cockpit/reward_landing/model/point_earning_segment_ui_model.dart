import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_rule_ui_model.dart';

class PointEarningSegmentUiModel {
  String title;
  String subtitle;
  List<PointEarningRuleUiModel> pointEarningRuleList;

  PointEarningSegmentUiModel({
    required this.title,
    required this.subtitle,
    required this.pointEarningRuleList,
  });
}
