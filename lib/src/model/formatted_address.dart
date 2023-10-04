class FormattedAddress {
  String? address;
  String? street;
  String? postcode;
  String? neighborhood;
  String? city;
  String? formattedAddress;
  String? state;
  String? country;

  FormattedAddress(
      {this.address,
      this.street,
      this.postcode,
      this.neighborhood,
      this.city,
      this.formattedAddress,
      this.state,
      this.country});

  FormattedAddress.fromJson(Map<String, dynamic> json) {
    for (var component in json['address_components']) {
      var componentType = component["types"][0];
      switch (componentType) {
        case "street_number":
          address = component['short_name'];
          break;
        case "route":
          street = component['short_name'];
          break;
        case "neighborhood":
          neighborhood = component['short_name'];
          break;
        case "postal_town":
          city = component['short_name'];
          break;
        case "postal_code":
          postcode = component['short_name'];
          break;
        case "formatted_address":
          formattedAddress = component['short_name'];
          break;
        case "country":
          country = component['short_name'];
          break;
        case "administrative_area_level_1":
          state = component['short_name'];
          break;
      }
    }
  }
}
