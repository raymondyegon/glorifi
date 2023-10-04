import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive_util.dart';

class ResponsiveUtilInit extends StatelessWidget {
  ResponsiveUtilInit({
    required this.builder,
    this.designSize = ResponsiveUtil.defaultSize,
    Key? key,
  }) : super(key: key);

  final Widget Function() builder;

  final Size designSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return OrientationBuilder(
        builder: (context, Orientation orientation) {
          if (constraints.maxWidth != 0) {
            ResponsiveUtil.init(
              constraints,
              orientation: orientation,
              designSize: designSize,
            );
            return builder();
          }
          return Container();
        },
      );
    });
  }
}
