// ignore_for_file: always_put_control_body_on_new_line

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'news_datum.dart';

@immutable
class GlorifiNewsFeed {
  final bool? status;
  final String? message;
  final List<NewsDatum>? newsData;

  const GlorifiNewsFeed({this.status, this.message, this.newsData});

  @override
  String toString() {
    return 'GlorifiNewsFeed(status: $status, message: $message, newsData: $newsData)';
  }

  factory GlorifiNewsFeed.fromMap(Map<String, dynamic> data) {
    return GlorifiNewsFeed(
      status: data['status'] as bool?,
      message: data['message'] as String?,
      newsData: (data['newsData'] as List<dynamic>?)
          ?.map((e) => NewsDatum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'newsData': newsData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GlorifiNewsFeed].
  factory GlorifiNewsFeed.fromJson(String data) {
    return GlorifiNewsFeed.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GlorifiNewsFeed] to a JSON string.
  String toJson() => json.encode(toMap());

  GlorifiNewsFeed copyWith({
    bool? status,
    String? message,
    List<NewsDatum>? newsData,
  }) {
    return GlorifiNewsFeed(
      status: status ?? this.status,
      message: message ?? this.message,
      newsData: newsData ?? this.newsData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GlorifiNewsFeed) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ newsData.hashCode;
}
