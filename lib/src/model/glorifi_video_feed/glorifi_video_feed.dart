// ignore_for_file: always_put_control_body_on_new_line

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'video_datum.dart';

@immutable
class GlorifiVideoFeed {
  final bool? status;
  final String? message;
  final List<VideoDatum>? videoData;

  const GlorifiVideoFeed({this.status, this.message, this.videoData});

  @override
  String toString() {
    return 'GlorifiVideoFeed(status: $status, message: $message, videoData: $videoData)';
  }

  factory GlorifiVideoFeed.fromMap(Map<String, dynamic> data) {
    return GlorifiVideoFeed(
      status: data['status'] as bool?,
      message: data['message'] as String?,
      videoData: (data['videoData'] as List<dynamic>?)
          ?.map((e) => VideoDatum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'videoData': videoData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GlorifiVideoFeed].
  factory GlorifiVideoFeed.fromJson(String data) {
    return GlorifiVideoFeed.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GlorifiVideoFeed] to a JSON string.
  String toJson() => json.encode(toMap());

  GlorifiVideoFeed copyWith({
    bool? status,
    String? message,
    List<VideoDatum>? videoData,
  }) {
    return GlorifiVideoFeed(
      status: status ?? this.status,
      message: message ?? this.message,
      videoData: videoData ?? this.videoData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GlorifiVideoFeed) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ videoData.hashCode;
}
