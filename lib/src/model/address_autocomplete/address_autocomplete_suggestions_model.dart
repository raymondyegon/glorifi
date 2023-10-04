///data for google places autocomplete
class AddressAutocompleteSuggestionsModel {
  final List<SingleAddressSuggestionModel> items;

  AddressAutocompleteSuggestionsModel({this.items = const []});

  factory AddressAutocompleteSuggestionsModel.fromJson(Map<String, dynamic> json) {
    final List<SingleAddressSuggestionModel> _items = [];
    if (json['predictions'] != null) {
      List<dynamic> _temp = json['predictions'];
      _items.addAll(_temp.map((e) => SingleAddressSuggestionModel.fromJson(e)));
    }

    return AddressAutocompleteSuggestionsModel(
      items: _items,
    );
  }
}

class SingleAddressSuggestionModel {
  final String id;
  final String description;

  SingleAddressSuggestionModel({
    required this.id,
    required this.description,
  });

  factory SingleAddressSuggestionModel.fromJson(Map<String, dynamic> json) {
    return SingleAddressSuggestionModel(
      id: json['place_id'],
      description: json['description'],
    );
  }
}
