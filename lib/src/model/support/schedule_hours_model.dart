class ScheduleHoursModel {
  bool? isOpenCallback;
  String? scheduleFormatted;
  bool? isOpenChat;
  bool? isOpenEmail;
  String? key;

  ScheduleHoursModel(
      {this.isOpenCallback,
        this.scheduleFormatted,
        this.isOpenChat,
        this.isOpenEmail,
        this.key});

  ScheduleHoursModel.fromJson(Map<String, dynamic> json) {
    isOpenCallback = json['isOpenCallback'];
    scheduleFormatted = json['ScheduleFormatted'];
    isOpenChat = json['isOpenChat'];
    isOpenEmail = json['IsOpenEmail'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isOpenCallback'] = isOpenCallback;
    data['ScheduleFormatted'] = scheduleFormatted;
    data['isOpenChat'] = isOpenChat;
    data['IsOpenEmail'] = isOpenEmail;
    data['key'] = key;
    return data;
  }

  @override
  String toString() => toJson().toString();
}
