import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_breakpoints.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';

class AdaptiveBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context, AdaptiveSizingInfo sizingInformation) builder;
  const AdaptiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        var mediaQuery = MediaQuery(
          data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window),
          child: LayoutBuilder(builder: (_, BoxConstraints constraints) {
            return Container();
          }),
        );
        var sizingInformation = AdaptiveSizingInfo(
          deviceType: getDeviceType(mediaQuery.data),
          screenSize: mediaQuery.data.size,
          localWidgetSize:
          Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
        );
        return builder(context, sizingInformation);
      },
    );
  }
}
