class ComparisonModel {
  bool? success;
  Data? data;
  String? status;
  String? message;

  ComparisonModel({
    this.success,
    this.data,
    this.status,
    this.message,
  });

  ComparisonModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  ComparisonItemData? netWorth;
  ComparisonItemData? homeValue;
  String? message;

  Data({
    this.netWorth,
    this.homeValue,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    ComparisonItemData? _netWorth;
    ComparisonItemData? _homeValue;
    if (json['comparisons'] != null) {
      json['comparisons'].forEach((v) {
        if (v['net_worth'] != null) {
          ComparisonItemData _item = ComparisonItemData.fromJson(v['net_worth']);
          _netWorth = _item;
        } else if (v['home_value'] != null) {
          ComparisonItemData _item = ComparisonItemData.fromJson(v['home_value']);
          _homeValue = _item;
        }
      });
    }
    return Data(
      netWorth: _netWorth,
      homeValue: _homeValue,
      message: json['Message'],
    );
  }
}

class ComparisonItemData {
  String comparison = "0.0";
  ComparisonDetailData? comparisonData;

  ComparisonItemData({this.comparison = "0.0", this.comparisonData});

  ComparisonItemData.fromJson(Map<String, dynamic> json) {
    comparison = json['comparison'].toString();
    comparisonData = json['comparison_data'] != null
        ? ComparisonDetailData.fromJson(json['comparison_data'])
        : null;
  }
}

class ComparisonDetailData {
  String? state;
  String? city;
  String? ageRange;
  String? martialStatus;

  ComparisonDetailData({this.city, this.ageRange, this.martialStatus});

  ComparisonDetailData.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    city = json['city'];
    ageRange = json['age_range'];
    martialStatus = json['martial_status'];
  }
}
