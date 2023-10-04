class DisplayIdentifier {
  String? addrAddressLine1;
  String? addrCity;
  String? addrState;
  String? addrPostCode;
  String? vehicleYear;
  String? vehicleType;
  String? vehicleModel;
  String? name;

  DisplayIdentifier(
      {this.addrAddressLine1,
      this.addrCity,
      this.addrState,
      this.addrPostCode,
      this.vehicleYear,
      this.vehicleType,
      this.vehicleModel,
      this.name});

  DisplayIdentifier.fromJson(Map<String, dynamic> json) {
    addrAddressLine1 = json['addr_address_line1'];
    addrCity = json['addr_city'];
    addrState = json['addr_state'];
    addrPostCode = json['addr_post_code'];
    vehicleYear = json['vehicle_year'];
    vehicleType = json['vehicle_type'];
    vehicleModel = json['vehicle_model'];
    name = json['name'];
  }

  String? getDetails() {
    if (addrAddressLine1 != null && addrCity != null && addrState != null) {
      return "$addrAddressLine1 $addrCity $addrState";
    } else if (vehicleYear != null && vehicleModel != null) {
      return "$vehicleYear $vehicleModel";
    } else if (name != null) {
      return "$name";
    } else {
      return "";
    }
  }

  String getPolicyDetails() {
    if (addrAddressLine1 != null && addrCity != null && addrState != null) {
      return "$addrAddressLine1 \n$addrCity $addrState";
    } else if (vehicleYear != null && vehicleModel != null) {
      return "$vehicleYear \n$vehicleModel";
    } else if (name != null) {
      return "$name";
    } else {
      return "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['addr_address_line1'] = addrAddressLine1;
    data['addr_city'] = addrCity;
    data['addr_state'] = addrState;
    data['addr_post_code'] = addrPostCode;
    data['vehicle_year'] = vehicleYear;
    data['vehicle_type'] = vehicleType;
    data['vehicle_model'] = vehicleModel;
    data['name'] = name;
    return data;
  }
}
