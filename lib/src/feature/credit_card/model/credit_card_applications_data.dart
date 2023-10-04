class CreditCardApplicationsData {
  CreditCardApplicationsData({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final String success;
  late final List<ApplicationsData> data;
  late final String status;
  late final String message;

  CreditCardApplicationsData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data'])
        .map((e) => ApplicationsData.fromJson(e))
        .toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class ApplicationsData {
  ApplicationsData({
    required this.id,
    required this.solutionSubType,
    required this.loanPurposeType,
    required this.status,
    required this.createdDate,
  });
  late final String id;
  late final String solutionSubType;
  late final String loanPurposeType;
  late final String status;
  late final String createdDate;

  ApplicationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    solutionSubType = json['solutionSubType'];
    loanPurposeType = json['loanPurposeType'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['solutionSubType'] = solutionSubType;
    _data['loanPurposeType'] = loanPurposeType;
    _data['status'] = status;
    _data['createdDate'] = createdDate;
    return _data;
  }
}
