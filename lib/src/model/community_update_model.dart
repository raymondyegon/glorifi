import 'dart:convert';

class CommunityUpdateModel {
  String id;
  String? userImageUrl;
  String displayName;
  String location;
  String content;
  DateTime date;
  int numLikes;
  bool liked;

  CommunityUpdateModel({
    required this.id,
    this.userImageUrl,
    required this.displayName,
    required this.location,
    required this.content,
    required this.date,
    required this.numLikes,
    this.liked = false,
  });

  CommunityUpdateModel copyWith({
    String? id,
    String? userImageUrl,
    String? displayName,
    String? location,
    String? content,
    DateTime? date,
    int? numLikes,
    bool? liked,
  }) {
    return CommunityUpdateModel(
      id: id ?? this.id,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      displayName: displayName ?? this.displayName,
      location: location ?? this.location,
      content: content ?? this.content,
      date: date ?? this.date,
      numLikes: numLikes ?? this.numLikes,
      liked: liked ?? this.liked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userImageUrl': userImageUrl,
      'displayName': displayName,
      'location': location,
      'content': content,
      'date': date.millisecondsSinceEpoch,
      'numLikes': numLikes,
      'liked': liked,
    };
  }

  factory CommunityUpdateModel.fromMap(Map<String, dynamic> map) {
    return CommunityUpdateModel(
      id: map['id'] ?? '',
      userImageUrl: map['userImageUrl'],
      displayName: map['displayName'] ?? '',
      location: map['location'] ?? '',
      content: map['content'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      numLikes: map['numLikes']?.toInt() ?? 0,
      liked: map['liked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityUpdateModel.fromJson(String source) =>
      CommunityUpdateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommunityUpdateModel(id: $id, userImageUrl: $userImageUrl, displayName: $displayName, location: $location, content: $content, date: $date, numLikes: $numLikes, liked: $liked)';
  }

  @override
  bool operator ==(Object other) {
    // ignore: always_put_control_body_on_new_line
    if (identical(this, other)) return true;

    return other is CommunityUpdateModel &&
        other.id == id &&
        other.userImageUrl == userImageUrl &&
        other.displayName == displayName &&
        other.location == location &&
        other.content == content &&
        other.date == date &&
        other.numLikes == numLikes &&
        other.liked == liked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userImageUrl.hashCode ^
        displayName.hashCode ^
        location.hashCode ^
        content.hashCode ^
        date.hashCode ^
        numLikes.hashCode ^
        liked.hashCode;
  }
}
