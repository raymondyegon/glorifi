///address detail from google places
class PlaceDetailModel {
  final String streetNumber;
  final String route;
  final String city;
  final String zipCode;
  final String state;
  final String stateShort;

  PlaceDetailModel({
    required this.streetNumber,
    required this.route,
    required this.city,
    required this.zipCode,
    required this.state,
    required this.stateShort,
  });

  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) {
    String _streetNumber = '';
    String _route = '';
    String _city = '';
    String _zipCode = '';
    String _state = '';
    String _stateShort = '';

    final address_components = json['result']['address_components'];

    for (Map<String, dynamic> _component in address_components) {
      switch (_component['types'][0]) {
        case 'street_number':
          _streetNumber = _component['long_name'] ?? '';
          break;
        case 'route':
          _route = _component['long_name'] ?? '';
          break;
        case 'locality':
          _city = _component['long_name'] ?? '';
          break;
        case 'administrative_area_level_1':
          _state = _component['long_name'] ?? '';
          _stateShort = _component['short_name'] ?? '';
          break;
        case 'postal_code':
          _zipCode = _component['long_name'] ?? '';
          break;
      }
    }

    return PlaceDetailModel(
      streetNumber: _streetNumber,
      route: _route,
      city: _city,
      zipCode: _zipCode,
      state: _state,
      stateShort: _stateShort,
    );
  }
}
