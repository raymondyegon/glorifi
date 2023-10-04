import 'package:flutter/material.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/errors/widget/error_no_internet.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class DemoErrorScreen extends StatelessWidget {
  const DemoErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
        builder: (context, sizingInfo) => AdaptiveScaffold(
              backgroundColor: GlorifiColors.productsBgWhite,
              showSimpleAppBar: sizingInfo.isWebMobile ? false : true,
              hideWebAppBar: sizingInfo.isWebMobile ? true : false,
              body: ErrorNoInternet(
                onTap: () {
                  Log.debug("Error Action Tapped");
                },
              ),
            ));
  }
}
