// ignore_for_file: always_put_control_body_on_new_line

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class WordpressNewsDatum {
  final String? newsTitle;
  final String? readTime;
  final String? imageUrl;

  const WordpressNewsDatum({this.newsTitle, this.readTime, this.imageUrl});

  @override
  String toString() {
    return 'WordpressNewsDatum(newsTitle: $newsTitle, readTime: $readTime, imageUrl: $imageUrl)';
  }

  factory WordpressNewsDatum.fromMap(Map<String, dynamic> data) {
    return WordpressNewsDatum(
      newsTitle: data['newsTitle'] as String?,
      readTime: data['readTime'] as String?,
      imageUrl: data['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'newsTitle': newsTitle,
        'readTime': readTime,
        'imageUrl': imageUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WordpressNewsDatum].
  factory WordpressNewsDatum.fromJson(String data) {
    return WordpressNewsDatum.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WordpressNewsDatum] to a JSON string.
  String toJson() => json.encode(toMap());

  WordpressNewsDatum copyWith({
    String? newsTitle,
    String? readTime,
    String? imageUrl,
  }) {
    return WordpressNewsDatum(
      newsTitle: newsTitle ?? this.newsTitle,
      readTime: readTime ?? this.readTime,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other is! WordpressNewsDatum) {
      return false;
    }
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      newsTitle.hashCode ^ readTime.hashCode ^ imageUrl.hashCode;
}
