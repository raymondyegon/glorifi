import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../glorifi_video_getx_controller.dart';
import '../../video_enums.dart';
import '../glorifi_video_progress_bar.dart';
import 'overlays/overlays.dart';

class GlorifiCorePlayer extends StatelessWidget {
  final VideoPlayerController videoPlayerCtr;
  final double videoAspectRatio;
  final String tag;
  const GlorifiCorePlayer({
    Key? key,
    required this.videoPlayerCtr,
    required this.videoAspectRatio,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GlorifiVideoGetXController>(tag: tag);
    return RawKeyboardListener(
      autofocus: true,
      focusNode: (controller.isFullScreen
              ? FocusNode()
              : controller.keyboardFocusWeb) ??
          FocusNode(),
      onKey: (value) => controller.onKeyBoardEvents(
        event: value,
        appContext: context,
        tag: tag,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: videoAspectRatio,
              child: VideoPlayer(videoPlayerCtr),
            ),
          ),
          VideoOverlays(tag: tag),
          IgnorePointer(
            child: GetBuilder<GlorifiVideoGetXController>(
              tag: tag,
              id: 'glorifiVideoState',
              builder: (_controller) {
                const loadingWidget = Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                );
                if (kIsWeb) {
                  switch (_controller.glorifiVideoState) {
                    case GlorifiVideoState.loading:
                      return loadingWidget;
                    case GlorifiVideoState.paused:
                      return const Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 45,
                          color: Colors.white,
                        ),
                      );
                    case GlorifiVideoState.playing:
                      return Center(
                        child: TweenAnimationBuilder<double>(
                          builder: (context, value, child) => Opacity(
                            opacity: value,
                            child: child,
                          ),
                          tween: Tween<double>(begin: 1, end: 0),
                          duration: const Duration(seconds: 1),
                          child: const Icon(
                            Icons.pause,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                      );
                    case GlorifiVideoState.error:
                      return const SizedBox();
                  }
                } else {
                  if (controller.glorifiVideoState ==
                      GlorifiVideoState.loading) {
                    return loadingWidget;
                  }
                  return const SizedBox();
                }
              },
            ),
          ),
          if (!kIsWeb)
            GetBuilder<GlorifiVideoGetXController>(
              tag: tag,
              id: 'full-screen',
              builder: (_controller) => _controller.isFullScreen
                  ? const SizedBox()
                  : GetBuilder<GlorifiVideoGetXController>(
                      tag: tag,
                      id: 'overlay',
                      builder: (_controller) => _controller.isOverlayVisible ||
                              !_controller.alwaysShowProgressBar
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: GlorifiVideoProgressBar(
                                tag: tag,
                                alignment: Alignment.bottomCenter,
                                glorifiProgressBarConfig:
                                    _controller.glorifiProgressBarConfig,
                              ),
                            ),
                    ),
            ),
        ],
      ),
    );
  }
}
