import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../glorifi_video_getx_controller.dart';
import '../../glorifi_video_progress_bar.dart';
import '../../material_icon_button.dart';

class MobileOverlayBottomControllers extends StatelessWidget {
  final String tag;

  const MobileOverlayBottomControllers({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoProgress = Get.find<GlorifiVideoGetXController>(tag: tag);
    const durationTextStyle = TextStyle(color: Colors.white70);
    const itemColor = Colors.white;

    return GetBuilder<GlorifiVideoGetXController>(
      tag: tag,
      id: 'full-screen',
      builder: (fullscreen) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(width: 12),
              GetBuilder<GlorifiVideoGetXController>(
                tag: tag,
                id: 'video-progress',
                builder: (videoProgress) {
                  return Text(
                      videoProgress
                          .calculateVideoDuration(videoProgress.videoPosition),
                      style: const TextStyle(color: itemColor));
                },
              ),
              const Text(
                ' / ',
                style: durationTextStyle,
              ),
              Text(
                videoProgress
                    .calculateVideoDuration(videoProgress.videoDuration),
                style: durationTextStyle,
              ),
              const Spacer(),
              MaterialIconButton(
                toolTipMesg: videoProgress.isFullScreen
                    ? 'Exit full screen${kIsWeb ? ' (f)' : ''}'
                    : 'Fullscreen${kIsWeb ? ' (f)' : ''}',
                color: itemColor,
                onPressed: () {
                  if (videoProgress.isOverlayVisible) {
                    if (fullscreen.isFullScreen) {
                      videoProgress.exitFullScreenView(context, tag);
                    } else {
                      videoProgress.enableFullScreenView(context, tag);
                    }
                  } else {
                    videoProgress.toggleVideoOverlay();
                  }
                },
                child: Icon(
                  fullscreen.isFullScreen
                      ? Icons.fullscreen_exit
                      : Icons.fullscreen,
                ),
              ),
            ],
          ),
          GetBuilder<GlorifiVideoGetXController>(
            tag: tag,
            id: 'overlay',
            builder: (videoProgress) {
              if (fullscreen.isFullScreen) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                  child: Visibility(
                    visible: videoProgress.isOverlayVisible,
                    child: GlorifiVideoProgressBar(
                      tag: tag,
                      alignment: Alignment.topCenter,
                      glorifiProgressBarConfig:
                          videoProgress.glorifiProgressBarConfig,
                    ),
                  ),
                );
              }
              return GlorifiVideoProgressBar(
                tag: tag,
                alignment: Alignment.bottomCenter,
                glorifiProgressBarConfig:
                    videoProgress.glorifiProgressBarConfig,
              );
            },
          ),
        ],
      ),
    );
  }
}
