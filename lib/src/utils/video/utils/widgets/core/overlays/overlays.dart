import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/video/models/overlay_options.dart';

import '../../../../glorifi_video_getx_controller.dart';
import '../../glorifi_video_progress_bar.dart';
import '../video_gesture_detector.dart';
import 'mobile_overlay.dart';

class VideoOverlays extends StatelessWidget {
  final String tag;
  const VideoOverlays({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GlorifiVideoGetXController>(tag: tag);
    if (controller.overlayBuilder != null) {
      return GetBuilder<GlorifiVideoGetXController>(
        id: 'update-all',
        tag: tag,
        builder: (controller) {
          final _progressBar = GlorifiVideoProgressBar(
            tag: tag,
            glorifiProgressBarConfig: controller.glorifiProgressBarConfig,
          );
          final overlayOptions = OverLayOptions(
            glorifiVideoState: controller.glorifiVideoState,
            videoDuration: controller.videoDuration,
            videoPosition: controller.videoPosition,
            isFullScreen: controller.isFullScreen,
            isLooping: controller.isLooping,
            isOverlayVisible: controller.isOverlayVisible,
            isMute: controller.isMute,
            autoPlay: controller.autoPlay,
            currentVideoPlaybackSpeed: controller.currentPaybackSpeed,
            videoPlayBackSpeeds: controller.videoPlaybackSpeeds,
            videoPlayerType: controller.videoPlayerType,
            progressBar: _progressBar,
          );
          return Stack(
            children: [
              Positioned.fill(
                child: VideoGestureDetector(
                  tag: tag,
                  onTap: controller.togglePlayPauseVideo,
                  onDoubleTap: controller.toggleFullScreenOnWeb,
                  child: const ColoredBox(
                    color: Colors.black38,
                    child: SizedBox.expand(),
                  ),
                ),
              ),
              controller.overlayBuilder?.call(overlayOptions) ??
                  const SizedBox(),
            ],
          );
        },
      );
    } else {
      return GetBuilder<GlorifiVideoGetXController>(
        tag: tag,
        id: 'overlay',
        builder: (controller) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: controller.isOverlayVisible ? 1 : 0,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (!kIsWeb) MobileOverlay(tag: tag),
                // if (kIsWeb) _WebOverlay(tag: tag),
              ],
            ),
          );
        },
      );
    }
  }
}
