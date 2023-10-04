// ignore_for_file: always_put_control_body_on_new_line

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class NewsDatum {
  final String? newsTitle;
  final String? sourceUrl;
  final String? imageUrl;

  const NewsDatum({this.newsTitle, this.sourceUrl, this.imageUrl});

  @override
  String toString() {
    return 'NewsDatum(newsTitle: $newsTitle, sourceUrl: $sourceUrl, imageUrl: $imageUrl)';
  }

  factory NewsDatum.fromMap(Map<String, dynamic> data) => NewsDatum(
        newsTitle: data['newsTitle'] as String?,
        sourceUrl: data['sourceUrl'] as String?,
        imageUrl: data['imageUrl'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'newsTitle': newsTitle,
        'sourceUrl': sourceUrl,
        'imageUrl': imageUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NewsDatum].
  factory NewsDatum.fromJson(String data) {
    return NewsDatum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NewsDatum] to a JSON string.
  String toJson() => json.encode(toMap());

  NewsDatum copyWith({
    String? newsTitle,
    String? sourceUrl,
    String? imageUrl,
  }) {
    return NewsDatum(
      newsTitle: newsTitle ?? this.newsTitle,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NewsDatum) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      newsTitle.hashCode ^ sourceUrl.hashCode ^ imageUrl.hashCode;
}
