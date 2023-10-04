// To parse this JSON data, do
//
//     final notificationModels = notificationModelsFromJson(jsonString);

// todo

class NotificationModels {
  NotificationModels({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final NotificationData data;
  late var status;
  late var message;

  NotificationModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = NotificationData.fromJson(json['data']);
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class NotificationData {
  NotificationData({
    required this.messages,
  });
  late final List<Messages> messages;

  NotificationData.fromJson(Map<String, dynamic> json) {
    messages =
        List.from(json['messages']).map((e) => Messages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['messages'] = messages.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Messages {
  Messages({
    required this.messageId,
    required this.title,
    required this.subtitle,
    required this.read,
    required this.timestamp,
  });
  late var messageId;
  late var title;
  late var subtitle;
  late final bool read;
  late var timestamp;

  Messages.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    title = json['title'];
    subtitle = json['subtitle'];
    read = json['read'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message_id'] = messageId;
    _data['title'] = title;
    _data['subtitle'] = subtitle;
    _data['read'] = read;
    _data['timestamp'] = timestamp;
    return _data;
  }
}
