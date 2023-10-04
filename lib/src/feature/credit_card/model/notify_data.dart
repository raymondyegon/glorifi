class NotifyData {
  NotifyData({
    required this.success,
    this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final Data? data;
  late final String status;
  late final String message;

  NotifyData.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  Data({
    this.Notified,
  });
  late final bool? Notified;

  Data.fromJson(Map<String, dynamic> json){
    Notified = json['Notified']?? false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Notified'] = Notified;
    return _data;
  }
}