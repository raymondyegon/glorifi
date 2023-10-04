import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_screen_type.dart';

class AdaptiveScreenLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? webMobile;
  final Widget? tablet;
  final Widget? desktop;

  const AdaptiveScreenLayout({
    Key? key,
    required this.mobile,
    this.webMobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceType == AdaptiveScreenType.tablet) {
          if (tablet != null) {
            return tablet!;
          }
        }

        if (sizingInformation.deviceType == AdaptiveScreenType.desktop) {
          if (desktop != null) {
            return desktop!;
          }
        }

        if (sizingInformation.deviceType == AdaptiveScreenType.webMobile) {
          if (webMobile != null) {
            return webMobile!;
          }
        }
        return mobile;
      },
    );
  }
}
