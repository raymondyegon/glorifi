import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_screen_type.dart';

class AdaptiveSizingInfo {
  final AdaptiveScreenType deviceType;
  final Size screenSize;
  final Size localWidgetSize;

  AdaptiveSizingInfo({
    required this.deviceType,
    required this.screenSize,
    required this.localWidgetSize,
  });

  @override
  String toString() {
    return 'DeviceType:$deviceType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }

  bool get isDesktop => deviceType == AdaptiveScreenType.desktop;
  bool get isTablet => deviceType == AdaptiveScreenType.tablet;
  bool get isWebMobile => deviceType == AdaptiveScreenType.webMobile;
  bool get isNativeMobile => deviceType == AdaptiveScreenType.nativeMobile;
}
