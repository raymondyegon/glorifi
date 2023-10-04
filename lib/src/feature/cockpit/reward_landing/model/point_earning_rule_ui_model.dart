import 'package:glorifi/src/feature/cockpit/reward_landing/model/reward_point_rule_type.dart';

class PointEarningRuleUiModel {
  RewardPointRuleType type;
  String title;
  String subtitle;
  String iconPath;

  PointEarningRuleUiModel({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });
}
