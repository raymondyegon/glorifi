import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    required this.body,
    required this.titleMobile,
  }) : super(key: key);

  final Widget body;
  final String titleMobile;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: GlorifiColors.productsBgWhite,
      appBar: GlorifiAppBar(
        title: titleMobile,
        textStyle: bodyExtraBold18Secondary(
          color: Colors.white,
        ),
        bgColor: Color(0xFF141B3F),
        leadingIconDefaultColor: Colors.white,
      ),
      body: body,
    );
  }
}

Widget titleDesktop(String title) {
  return Container(
    color: GlorifiColors.bgColor,
    width: double.maxFinite,
    height: 122.h,
    child: Center(
      child: Container(
        width: 1024.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: headlineBold26Secondary(
                color: GlorifiColors.almostBlack,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget containerDesktop(Widget child,
    {required AdaptiveSizingInfo sizingInfo}) {
  return Center(
    child: Container(
      width: sizingInfo.isDesktop ? 1024.w : double.maxFinite,
      child: child,
    ),
  );
}
