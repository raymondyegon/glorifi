import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/header.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_tappable.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/play_button.dart';
import 'package:glorifi/src/widgets/loading/blue_background.dart';

class BaseStory extends GetView<StoryController> {
  final Widget child;
  final String? backgroundImageURL;
  final String? backgroundImageAsset;
  final Widget? modal;
  final bool isFirstStory;
  final Function? onTap;
  final bool playButton;

  const BaseStory(
      {Key? key,
      this.modal = null,
      this.onTap,
      required Widget this.child,
      this.isFirstStory = false,
      this.playButton = false,
      this.backgroundImageURL,
      this.backgroundImageAsset})
      : super(key: key);

  Widget _image({fit, height, width}) {
    if (backgroundImageURL != null) {
      return CachedNetworkImage(
      fit: fit,
        imageUrl: backgroundImageURL!,
      placeholder: (context, url) => BlueBackground(),
      errorWidget: (context, url, error) => BlueBackground(),
      height: height,
      width: width,
    );
    } else if (backgroundImageAsset != null) {
      return Image.asset(
        backgroundImageAsset!,
        fit: fit,
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _addBackground(child, backgroundImage, AdaptiveSizingInfo sizingInfo) {
    return Stack(children: [
      Container(
        height: 1.sh,
        width: 1.sw,
        child: _image(fit: BoxFit.cover),
      ),
      Container(
        height: 1.sh,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            colors: [
              GlorifiColors.defaultGradientStartColor.withOpacity(0.9),
              GlorifiColors.defaultGradientEndColor,
            ],
            tileMode: TileMode.mirror,
            stops: [0.0, 1.0],
          ),
        ),
      ),
      Container(
        height: 1.sh,
        child: child,
        alignment: Alignment.bottomCenter,
      ),
      if (playButton)
        Center(
          child: PlayButton(
              height:
                  sizingInfo.isDesktop || sizingInfo.isTablet ? 100.h : 80.h),
        ),
    ]);
  }

  Widget _addHeader(child) {
    if (isFirstStory) {
      return Header(
        child: child,
        color: Colors.transparent,
      );
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, AdaptiveSizingInfo sizingInfo) {
      Widget _child = backgroundImageURL != null || backgroundImageAsset != null
          ? _addHeader(_addBackground(child, backgroundImageURL, sizingInfo))
          : child;

    if (modal != null || onTap != null) {
      return BaseTapStory(
        modal: modal,
        child: _child,
        onTap: onTap,
      );
    }
    return _child;
    });
  }
}
