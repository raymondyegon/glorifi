import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class ProfileAppBar extends StatefulWidget {
  final Function() onTap;
  final double percent;
  final List<String> titles;
  final String activeTitle;

  ProfileAppBar({
    Key? key,
    required this.onTap,
    required this.percent,
    this.titles = const [],
    this.activeTitle = "",
  }) : super(key: key);

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  final double leftIconSize = 24;
  final double rightIconSize = 18;

  @override
  Widget build(BuildContext context) {
    final bool hasTitle = (kIsWeb || GetPlatform.isDesktop) && widget.titles.isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _getProgressBar(),
        hasTitle
            ? Container(
                margin: EdgeInsets.only(
                  right: rightIconSize,
                  left: leftIconSize,
                ),
                child: _getProgressBarTitles(),
              )
            : Container(),
      ],
    );
  }

  _getProgressBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Ripple(
          onTap: widget.onTap,
          child: Icon(
            Icons.arrow_back,
            color: profileTextColor,
            size: leftIconSize,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: LinearProgressIndicator(
              value: widget.percent,
              color: GlorifiColors.selectedIndicatorColor,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        Icon(
          Icons.star,
          color: GlorifiColors.selectedIndicatorColor,
          size: rightIconSize,
        ),
      ],
    );
  }

  Row _getProgressBarTitles() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.titles
          .map((title) => Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: isTitleActive(title)
                      ? xSmallBold12Primary(color: GlorifiColors.white)
                      : xSmallRegular12Primary(color: GlorifiColors.white),
                ),
              ))
          .toList(),
    );
  }

  bool isTitleActive(currentTitle) => widget.activeTitle == currentTitle;

}
