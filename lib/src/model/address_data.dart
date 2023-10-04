class AddressData {
  AddressData();

  late final int addrType;
  late final String addrValue;
  late final String addrDesription;
  late final int addrId;
  late final String addrAddressLine1;
  late final String addrAddressLine2;
  late final String addrCity;
  late final String addrState;
  late final String addrPostalCode;
  late final String addrLatitude;
  late final String addrLongitude;
  late final String validFromDate;
  late final String validToDate;

  AddressData.fromJson(Map<String, dynamic> json) {
    addrType = json['addr_type'] ?? '';
    addrValue = json['addr_value'] ?? '';
    addrDesription = json['addr_desription'] ?? '';
    addrId = json['addr_id'] ?? '';
    addrAddressLine1 = json['addr_address_line1'] ?? '';
    addrAddressLine2 = json['addr_address_line2'] ?? '';
    addrCity = json['addr_city'] ?? '';
    addrState = json['addr_state'] ?? '';
    addrPostalCode = json['addr_postal_code'] ?? '';
    addrLatitude = json['addr_latitude'] ?? '';
    addrLongitude = json['addr_longitude'] ?? '';
    validFromDate = json['valid_from_date'] ?? '';
    validToDate = json['valid_to_date'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['addr_type'] = addrType;
    _data['addr_value'] = addrValue;
    _data['addr_desription'] = addrDesription;
    _data['addr_id'] = addrId;
    _data['addr_address_line1'] = addrAddressLine1;
    _data['addr_address_line2'] = addrAddressLine2;
    _data['addr_city'] = addrCity;
    _data['addr_state'] = addrState;
    _data['addr_postal_code'] = addrPostalCode;
    _data['addr_latitude'] = addrLatitude;
    _data['addr_longitude'] = addrLongitude;
    _data['valid_from_date'] = validFromDate;
    _data['valid_to_date'] = validToDate;
    return _data;
  }
}
