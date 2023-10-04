// ignore_for_file: always_put_control_body_on_new_line

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'wordpress_news_datum.dart';

@immutable
class WordpressNewsFeed {
  final bool? status;
  final String? message;
  final List<WordpressNewsDatum>? wordpressNewsData;

  const WordpressNewsFeed({
    this.status,
    this.message,
    this.wordpressNewsData,
  });

  @override
  String toString() {
    return 'WordpressNewsFeed(status: $status, message: $message, wordpressNewsData: $wordpressNewsData)';
  }

  factory WordpressNewsFeed.fromMap(Map<String, dynamic> data) {
    return WordpressNewsFeed(
      status: data['status'] as bool?,
      message: data['message'] as String?,
      wordpressNewsData: (data['wordpressNewsData'] as List<dynamic>?)
          ?.map((e) => WordpressNewsDatum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'wordpressNewsData': wordpressNewsData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WordpressNewsFeed].
  factory WordpressNewsFeed.fromJson(String data) {
    return WordpressNewsFeed.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WordpressNewsFeed] to a JSON string.
  String toJson() => json.encode(toMap());

  WordpressNewsFeed copyWith({
    bool? status,
    String? message,
    List<WordpressNewsDatum>? wordpressNewsData,
  }) {
    return WordpressNewsFeed(
      status: status ?? this.status,
      message: message ?? this.message,
      wordpressNewsData: wordpressNewsData ?? this.wordpressNewsData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! WordpressNewsFeed) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      status.hashCode ^ message.hashCode ^ wordpressNewsData.hashCode;
}
