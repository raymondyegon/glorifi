import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../../../../widgets/web/page_header.dart';

class ContactSupportAppBar extends StatelessWidget {
  final String title;
  final Widget body;
  final String trailingLabel;
  final Function? onTap;
  final TextStyle? textStyle;
  final double toolbarHeight;
  final Widget? flexible;
  final bool centerTitle;
  final Leading? leading;

  const ContactSupportAppBar({
    Key? key,
    this.title: 'Contact Support',
    this.trailingLabel: 'Close',
    required this.body,
    this.onTap,
    this.textStyle,
    this.toolbarHeight: 84,
    this.flexible,
    this.centerTitle: false,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          backgroundColor: GlorifiColors.productsBgWhite,
          appBar: GlorifiAppBar(
            title: title,
            leading: leading,
            trailing: Trailing(
              text: trailingLabel,
              onTap: () => onTap!(),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!sizingInfo.isNativeMobile)
                  PageHeader(
                      headerTitle: title,
                      showTrailingButton: false,
                      showWebPageFont: true,
                      horizontalPadding: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.5.w),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.w,
                    ),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1024),
                        child: body))
              ],
            ),
          ),
        );
      },
    );
  }
}

//Get.until((route) => !Get.currentRoute.contains('faq'))
