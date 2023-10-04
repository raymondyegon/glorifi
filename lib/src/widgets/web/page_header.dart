import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/credit_card/widgets/apply_button.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    required this.headerTitle,
    this.headerButtonTitle = "Apply",
    this.headerButtonOnTap,
    this.horizontalPadding,
    this.showTrailingButton = true,
    this.showWebPageFont = false,
    this.showWebMobileVersionFont = false,
  }) : super(key: key);

  final String headerTitle;
  final String headerButtonTitle;
  final VoidCallback? headerButtonOnTap;
  final double? horizontalPadding;
  final bool showTrailingButton;
  final bool showWebPageFont;
  final bool showWebMobileVersionFont;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 24.5.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1024),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              headerTitle,
              style: showWebPageFont ?headlineBold26Primary(
                color:GlorifiColors.cornflowerBlue
              ):showWebMobileVersionFont ?headlineBold21SecondarySans(
                color: GlorifiColors.cornflowerBlue,
              ) :headlineRegular21Secondary(
                color: GlorifiColors.cornflowerBlue,
              ),
            ),
            if (showTrailingButton)
              ApplyButton(
                title: headerButtonTitle,
                onTap: headerButtonOnTap ?? () {},
              ),
          ],
        ),
      ),
    );
  }
}
