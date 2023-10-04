import 'package:intl/intl.dart';

class MortgageDataResponse {
  MortgageDataResponse({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final List<MortgageData> data;
  late final String status;
  late final String message;

  MortgageDataResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success) {
      data =
          List.from(json['data']).map((e) => MortgageData.fromJson(e)).toList();
    } else {
      data = [];
    }
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

class MortgageData {
  MortgageData({
    required this.id,
    required this.referenceNumber,
    this.solutionSubType,
    this.loanPurposeType,
    required this.status,
    required this.createdDate,
  });
  late final String id;
  late final String referenceNumber;
  late final String? solutionSubType;
  late final String? loanPurposeType;
  late final String status;
  late final String createdDate;

  MortgageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNumber = json['referenceNumber'];
    solutionSubType = json['solutionSubType'];
    loanPurposeType = json['loanPurposeType'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  String formattedCreatedDate() {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String formattedDate = formatter.format(DateTime.parse(createdDate));
    return formattedDate;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['referenceNumber'] = referenceNumber;
    _data['solutionSubType'] = solutionSubType;
    _data['loanPurposeType'] = loanPurposeType;
    _data['status'] = status;
    _data['createdDate'] = createdDate;
    return _data;
  }
}
