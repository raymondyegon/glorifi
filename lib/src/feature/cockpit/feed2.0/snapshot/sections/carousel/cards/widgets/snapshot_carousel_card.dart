import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/not_not_button.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/common_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class SnapshotCarouselCard extends StatelessWidget {
  final Widget topPart;
  final List<Widget>? bottomPart;
  final Function()? notNow;
  final bool isGraph;

  const SnapshotCarouselCard({
    Key? key,
    required this.topPart,
    this.bottomPart,
    this.notNow,
    this.isGraph = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.isWebMobile || sizingInfo.isNativeMobile) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 75, horizontal: 8),
          padding: EdgeInsets.only(
            bottom: isGraph ? 0 : 20,
            right: isGraph ? 0 : 20,
            left: isGraph ? 0 : 20,
            top: 16,
          ),
          decoration: BoxDecoration(
            color: isGraph ? GlorifiColors.midnightBlue : GlorifiColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: topPart),
              if (!isGraph)
                Row(
                  children: [
                    if (notNow != null)
                      NotNowButton(
                        onTap: notNow!,
                      ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: bottomPart!,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      }
      return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: GlorifiColors.white,
        ),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(child: topPart),
            Row(
              children: [
                if (notNow != null)
                  sizingInfo.isDesktop
                      ? NotNowButton(onTap: notNow)
                      : Expanded(child: NotNowButton(onTap: notNow)),
                Expanded(
                  child: Row(
                    children: bottomPart!,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
