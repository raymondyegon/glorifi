import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/loader/indicator.dart';

class CockpitTabScreen extends StatelessWidget {
  final Widget child;
  final Function onRefresh;
  const CockpitTabScreen(
      {Key? key, required this.child, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark, //Status bar icon/text color
        child: AdaptiveScaffold(
            body: GlorifiIndicator(
                child: Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: child,
                  color: GlorifiColors.productsBgWhite,
                ),
                onRefresh: () async {
                  await onRefresh();
                })));
  }
}
