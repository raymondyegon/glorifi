import 'package:get/get.dart';
import 'package:glorifi/src/controllers/DeveloperOptionsController.dart';

class AccountFlagsModel {
  AccountFlagsModel(
      {this.hasGlorifiAcct = false,
      this.hasPlaidLinkedAcct = false,
      this.hasCreditPermission = false,
      this.hasAddr = false,
      this.hasCustomerId = false,
      this.hasPlaidDebt = false,
      this.hasPlaidRetirement = false});

  bool hasCreditPermission;
  bool hasGlorifiAcct;
  bool hasPlaidLinkedAcct;
  bool hasAddr;
  bool hasPlaidDebt;
  bool hasCustomerId;
  bool hasPlaidRetirement;

  factory AccountFlagsModel.fromJson(Map<String, dynamic> json) {
    DeveloperOptionsController _controller =
        Get.find<DeveloperOptionsController>();
    return AccountFlagsModel(
      hasCustomerId: json['has_customer_id'],
      hasCreditPermission: _controller.isMockedCreditScoreEnabled.isTrue
          ? true
          : (json['has_credit_permission'] ?? false),
      hasGlorifiAcct: json['has_glorifi_acct'],
      hasPlaidLinkedAcct: json['has_plaid_acct'],
      hasAddr: json['has_addr_flag'],
      hasPlaidDebt: json['has_plaid_debt'],
      hasPlaidRetirement: json['has_plaid_retirement'],
    );
  }
}
