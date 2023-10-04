import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:glorifi/src/utils/video/models/glorifi_video_progress_bar_config.dart';
import 'package:video_player/video_player.dart';

import '../../glorifi_video_getx_controller.dart';

/// Renders progress bar for the video using custom paint.
class GlorifiVideoProgressBar extends StatefulWidget {
  const GlorifiVideoProgressBar({
    Key? key,
    GlorifiProgressBarConfig? glorifiProgressBarConfig,
    this.onDragStart,
    this.onDragEnd,
    this.onDragUpdate,
    this.alignment = Alignment.center,
    required this.tag,
  })  : glorifiProgressBarConfig =
            glorifiProgressBarConfig ?? const GlorifiProgressBarConfig(),
        super(key: key);

  final GlorifiProgressBarConfig glorifiProgressBarConfig;
  final Function()? onDragStart;
  final Function()? onDragEnd;
  final Function()? onDragUpdate;
  final Alignment alignment;
  final String tag;

  @override
  State<GlorifiVideoProgressBar> createState() =>
      GlorifiVideoProgressBarState();
}

class GlorifiVideoProgressBarState extends State<GlorifiVideoProgressBar> {
  late final _controller =
      Get.find<GlorifiVideoGetXController>(tag: widget.tag);
  late VideoPlayerValue? videoPlayerValue = _controller.videoCtr?.value;
  bool _controllerWasPlaying = false;

  void seekToRelativePosition(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final Offset tapPos = box.globalToLocal(globalPosition);
      final double relative = tapPos.dx / box.size.width;
      final Duration position =
          (videoPlayerValue?.duration ?? Duration.zero) * relative;
      _controller.seekTo(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: always_put_control_body_on_new_line
    if (videoPlayerValue == null) return const SizedBox();

    return GetBuilder<GlorifiVideoGetXController>(
      tag: widget.tag,
      id: 'video-progress',
      builder: (_controller) {
        videoPlayerValue = _controller.videoCtr?.value;
        return LayoutBuilder(
          builder: (context, size) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: _progressBar(size),
              onHorizontalDragStart: (DragStartDetails details) {
                if (!videoPlayerValue!.isInitialized) {
                  return;
                }
                _controllerWasPlaying =
                    _controller.videoCtr?.value.isPlaying ?? false;
                if (_controllerWasPlaying) {
                  _controller.videoCtr?.pause();
                }

                if (widget.onDragStart != null) {
                  widget.onDragStart?.call();
                }
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                if (!videoPlayerValue!.isInitialized) {
                  return;
                }
                _controller.isShowOverlay(true);
                seekToRelativePosition(details.globalPosition);

                widget.onDragUpdate?.call();
              },
              onHorizontalDragEnd: (DragEndDetails details) {
                if (_controllerWasPlaying) {
                  _controller.videoCtr?.play();
                }
                _controller.toggleVideoOverlay();

                if (widget.onDragEnd != null) {
                  widget.onDragEnd?.call();
                }
              },
              onTapDown: (TapDownDetails details) {
                if (!videoPlayerValue!.isInitialized) {
                  return;
                }
                seekToRelativePosition(details.globalPosition);
              },
            );
          },
        );
      },
    );
  }

  MouseRegion _progressBar(BoxConstraints size) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: widget.glorifiProgressBarConfig.padding,
        child: SizedBox(
          width: size.maxWidth,
          height: widget.glorifiProgressBarConfig.circleHandlerRadius,
          child: Align(
            alignment: widget.alignment,
            child: GetBuilder<GlorifiVideoGetXController>(
              tag: widget.tag,
              id: 'overlay',
              builder: (_controller) => CustomPaint(
                painter: _ProgressBarPainter(
                  videoPlayerValue!,
                  glorifiProgressBarConfig:
                      widget.glorifiProgressBarConfig.copyWith(
                    circleHandlerRadius: _controller.isOverlayVisible ||
                            widget.glorifiProgressBarConfig
                                .alwaysVisibleCircleHandler
                        ? widget.glorifiProgressBarConfig.circleHandlerRadius
                        : 0,
                  ),
                ),
                size: Size(
                  double.maxFinite,
                  widget.glorifiProgressBarConfig.height,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressBarPainter extends CustomPainter {
  _ProgressBarPainter(this.value, {this.glorifiProgressBarConfig});

  VideoPlayerValue value;
  GlorifiProgressBarConfig? glorifiProgressBarConfig;

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double height = glorifiProgressBarConfig!.height;
    final double width = size.width;
    final double curveRadius = glorifiProgressBarConfig!.curveRadius;
    final double circleHandlerRadius =
        glorifiProgressBarConfig!.circleHandlerRadius;
    final Paint backgroundPaint =
        glorifiProgressBarConfig!.getBackgroundPaint != null
            ? glorifiProgressBarConfig!.getBackgroundPaint!(
                width: width,
                height: height,
                circleHandlerRadius: circleHandlerRadius,
              )
            : Paint()
          ..color = glorifiProgressBarConfig!.backgroundColor;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset.zero,
          Offset(width, height),
        ),
        Radius.circular(curveRadius),
      ),
      backgroundPaint,
    );
    if (value.isInitialized == false) {
      return;
    }

    final double playedPartPercent =
        value.position.inMilliseconds / value.duration.inMilliseconds;
    final double playedPart =
        playedPartPercent > 1 ? width : playedPartPercent * width;

    for (final DurationRange range in value.buffered) {
      final double start = range.startFraction(value.duration) * width;
      final double end = range.endFraction(value.duration) * width;

      final Paint bufferedPaint =
          glorifiProgressBarConfig!.getBufferedPaint != null
              ? glorifiProgressBarConfig!.getBufferedPaint!(
                  width: width,
                  height: height,
                  playedPart: playedPart,
                  circleHandlerRadius: circleHandlerRadius,
                  bufferedStart: start,
                  bufferedEnd: end,
                )
              : Paint()
            ..color = glorifiProgressBarConfig!.bufferedBarColor;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(
            Offset(start, 0),
            Offset(end, height),
          ),
          Radius.circular(curveRadius),
        ),
        bufferedPaint,
      );
    }

    final Paint playedPaint = glorifiProgressBarConfig!.getPlayedPaint != null
        ? glorifiProgressBarConfig!.getPlayedPaint!(
            width: width,
            height: height,
            playedPart: playedPart,
            circleHandlerRadius: circleHandlerRadius,
          )
        : Paint()
      ..color = glorifiProgressBarConfig!.playingBarColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset.zero,
          Offset(playedPart, height),
        ),
        Radius.circular(curveRadius),
      ),
      playedPaint,
    );

    final Paint handlePaint =
        glorifiProgressBarConfig!.getCircleHandlerPaint != null
            ? glorifiProgressBarConfig!.getCircleHandlerPaint!(
                width: width,
                height: height,
                playedPart: playedPart,
                circleHandlerRadius: circleHandlerRadius,
              )
            : Paint()
          ..color = glorifiProgressBarConfig!.circleHandlerColor;

    canvas.drawCircle(
      Offset(playedPart, height / 2),
      circleHandlerRadius,
      handlePaint,
    );
  }
}
