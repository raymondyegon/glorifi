// ignore_for_file: always_put_control_body_on_new_line

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class VideoDatum {
  final String? videoTitle;
  final String? videoUrl;
  final String? videoViews;
  final String? videoDuration;

  const VideoDatum({
    this.videoTitle,
    this.videoUrl,
    this.videoViews,
    this.videoDuration,
  });

  @override
  String toString() {
    return 'VideoDatum(videoTitle: $videoTitle, videoUrl: $videoUrl, videoViews: $videoViews, videoDuration: $videoDuration)';
  }

  factory VideoDatum.fromMap(Map<String, dynamic> data) => VideoDatum(
        videoTitle: data['videoTitle'] as String?,
        videoUrl: data['videoUrl'] as String?,
        videoViews: data['videoViews'] as String?,
        videoDuration: data['videoDuration'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'videoTitle': videoTitle,
        'videoUrl': videoUrl,
        'videoViews': videoViews,
        'videoDuration': videoDuration,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VideoDatum].
  factory VideoDatum.fromJson(String data) {
    return VideoDatum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VideoDatum] to a JSON string.
  String toJson() => json.encode(toMap());

  VideoDatum copyWith({
    String? videoTitle,
    String? videoUrl,
    String? videoViews,
    String? videoDuration,
  }) {
    return VideoDatum(
      videoTitle: videoTitle ?? this.videoTitle,
      videoUrl: videoUrl ?? this.videoUrl,
      videoViews: videoViews ?? this.videoViews,
      videoDuration: videoDuration ?? this.videoDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! VideoDatum) {
      return false;
    }
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      videoTitle.hashCode ^
      videoUrl.hashCode ^
      videoViews.hashCode ^
      videoDuration.hashCode;
}
