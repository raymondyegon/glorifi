class StateDataResponse {
  StateDataResponse({
    required this.productsAvailable,
  });
  late final List<ProductsAvailable> productsAvailable;

  StateDataResponse.fromJson(Map<String, dynamic> json) {
    productsAvailable = List.from(json['products-available'])
        .map((e) => ProductsAvailable.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products-available'] =
        productsAvailable.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductsAvailable {
  ProductsAvailable({
    required this.productIdNumber,
    required this.productName,
    required this.state,
    required this.stateName,
    required this.productAvailable,
    required this.productAvailabilityDate,
  });
  late final int productIdNumber;
  late final String productName;
  late final String state;
  late final String stateName;
  late final bool productAvailable;
  late final String? productAvailabilityDate;

  ProductsAvailable.fromJson(Map<String, dynamic> json) {
    productIdNumber = json['product_id_number'];
    productName = json['product_name'];
    state = json['state'];
    stateName = json['state_name'];
    productAvailable = json['product_available'];
    productAvailabilityDate = json['product_availability_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id_number'] = productIdNumber;
    _data['product_name'] = productName;
    _data['state'] = state;
    _data['state_name'] = stateName;
    _data['product_available'] = productAvailable;
    _data['product_availability_date'] = productAvailabilityDate;
    return _data;
  }
}
