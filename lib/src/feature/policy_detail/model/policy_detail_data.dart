import 'package:glorifi/src/feature/insurance/model/display_identifier.dart';
import 'package:intl/intl.dart';

class PolicyDetailData {
  PolicyDetailData({
    required this.policynumber,
    required this.effectivedate,
    required this.expirationdate,
    required this.vendor,
    required this.underwriter,
    required this.status,
    required this.displayIdentifier,
  });

  late final int policynumber;
  late final String effectivedate;
  late final String expirationdate;
  late final String vendor;
  late final String underwriter;
  late final String status;
  late final DisplayIdentifier displayIdentifier;

  String getExpiryDate() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate =
        formatter.format(DateTime.parse(expirationdate));
    return formattedDate;
  }

  bool showSubmitClaim() {
    String policyVendor = vendor.trim().toLowerCase();
    return policyVendor == "unqork";
  }

  String getEffectiveDate() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate =
        formatter.format(DateTime.parse(effectivedate));
    return formattedDate;
  }

  PolicyDetailData.fromJson(Map<String, dynamic> json) {
    policynumber = json['policynumber'];
    effectivedate = json['effectivedate'];
    expirationdate = json['expirationdate'];
    vendor = json['vendor'];
    underwriter = json['underwriter'];
    status = json['status'];
    displayIdentifier = DisplayIdentifier.fromJson(json['display_identifier']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['policynumber'] = policynumber;
    _data['effectivedate'] = effectivedate;
    _data['expirationdate'] = expirationdate;
    _data['vendor'] = vendor;
    _data['underwriter'] = underwriter;
    _data['status'] = status;
    _data['display_identifier'] = displayIdentifier.toJson();
    return _data;
  }
}
