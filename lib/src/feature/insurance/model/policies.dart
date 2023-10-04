import 'package:glorifi/src/feature/insurance/model/display_identifier.dart';

class Policies {
  Policies({
    required this.partyId,
    required this.policyName,
    required this.vendor,
    required this.policyId,
    required this.displayIdentifier,
  });
  late final int partyId;
  late final String policyName;
  late final String vendor;
  late final int policyId;
  late final DisplayIdentifier displayIdentifier;

  Policies.fromJson(Map<String, dynamic> json) {
    partyId = json['party_id'];
    policyName = json['policy_name'];
    vendor = json['vendor'];
    policyId = json['policy_id'];
    displayIdentifier = DisplayIdentifier.fromJson(json['display_identifier']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['party_id'] = partyId;
    _data['policy_name'] = policyName;
    _data['vendor'] = vendor;
    _data['policy_id'] = policyId;
    _data['display_identifier'] = displayIdentifier.toJson();
    return _data;
  }
}
