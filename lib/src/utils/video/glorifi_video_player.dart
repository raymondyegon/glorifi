import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/video/utils/video_enums.dart';
import 'package:glorifi/src/utils/video/utils/widgets/core/glorifi_core_player.dart';
import 'package:glorifi/src/utils/video/utils/widgets/material_icon_button.dart';
import 'package:universal_html/html.dart' as _html;

import 'glorifi_video_controller.dart';
import 'glorifi_video_getx_controller.dart';
import 'models/glorifi_video_progress_bar_config.dart';
import 'models/overlay_options.dart';

class GlorifiVideoPlayer extends StatefulWidget {
  final GlorifiVideoController controller;
  final double frameAspectRatio;
  final double videoAspectRatio;
  final bool alwaysShowProgressBar;
  final GlorifiProgressBarConfig glorifiProgressBarConfig;
  final Widget Function(OverLayOptions options)? overlayBuilder;
  GlorifiVideoPlayer({
    Key? key,
    required this.controller,
    this.frameAspectRatio = 16 / 9,
    this.videoAspectRatio = 16 / 9,
    this.alwaysShowProgressBar = true,
    this.glorifiProgressBarConfig = const GlorifiProgressBarConfig(),
    this.overlayBuilder,
  }) : super(key: key) {
    _validate();
    addToUiController();
  }

  void _validate() {
    final glorifiVideoController =
        Get.find<GlorifiVideoGetXController>(tag: controller.getTag);

    switch (glorifiVideoController.videoPlayerType) {
      case GlorifiVideoPlayerType.network:
        assert(
          glorifiVideoController.fromNetworkUrl != null,
          '''---------  GlorifiVideoController( fromVideoUrl: )-------- parameter is required  ---------''',
        );
        break;
      case GlorifiVideoPlayerType.auto:
        assert(
          glorifiVideoController.fromNetworkUrl != null,
          '''--------- add required parameters to GlorifiVideoController  ---------''',
        );
        break;
    }
  }

  void addToUiController() {
    //final glorifiVideoController =
    Get.find<GlorifiVideoGetXController>(tag: controller.getTag)

      ///add to ui
      ..alwaysShowProgressBar = alwaysShowProgressBar
      ..glorifiProgressBarConfig = glorifiProgressBarConfig
      ..overlayBuilder = overlayBuilder;
  }

  @override
  _GlorifiVideoPlayerState createState() => _GlorifiVideoPlayerState();
}

class _GlorifiVideoPlayerState extends State<GlorifiVideoPlayer>
    with SingleTickerProviderStateMixin {
  late GlorifiVideoGetXController _controller;
  // late String tag;
  @override
  void initState() {
    super.initState();
    // tag = widget.controller?.tag ?? UniqueKey().toString();
    _controller = Get.put(
      GlorifiVideoGetXController(),
      permanent: true,
      tag: widget.controller.getTag,
    )
      ..playPauseCtr = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 450),
      )
      ..webFullScreenListner(context, widget.controller.getTag);

    if (kIsWeb) {
      if (widget.controller.playerConfig.forcedVideoFocus) {
        _controller.keyboardFocusWeb = FocusNode();
        _controller.keyboardFocusWeb?.addListener(_controller.keyboardListener);
      }
      //to disable mouse right click
      _html.document.onContextMenu.listen((event) => event.preventDefault());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.glorifiVideoStateChanger(GlorifiVideoState.paused);
    if (kIsWeb) {
      _controller.keyboardFocusWeb
          ?.removeListener(_controller.keyboardListener);
    }
    _controller.playPauseCtr?.dispose();
    _controller.hoverOverlayTimer?.cancel();
    _controller.showOverlayTimer?.cancel();
    _controller.showOverlayTimer1?.cancel();
    _controller.leftDoubleTapTimer?.cancel();
    _controller.rightDoubleTapTimer?.cancel();
  }

  ///
  final circularProgressIndicator = const CircularProgressIndicator(
    backgroundColor: Colors.black87,
    color: Colors.white,
    strokeWidth: 2,
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlorifiVideoGetXController>(
      tag: widget.controller.getTag,
      builder: (_) {
        return Center(
          child: ColoredBox(
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: widget.frameAspectRatio,
              child: Center(
                child: _controller.videoCtr == null
                    ? circularProgressIndicator
                    : _controller.videoCtr!.value.isInitialized
                        ? _buildPlayer()
                        : circularProgressIndicator,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayer() {
    if (kIsWeb) {
      return GetBuilder<GlorifiVideoGetXController>(
        tag: widget.controller.getTag,
        id: 'full-screen',
        builder: (_controller) {
          // ignore: always_put_control_body_on_new_line
          if (_controller.isFullScreen) return circularProgressIndicator;
          return GlorifiCorePlayer(
            videoPlayerCtr: _controller.videoCtr!,
            videoAspectRatio: widget.videoAspectRatio,
            tag: widget.controller.getTag,
          );
        },
      );
    } else {
      return GlorifiCorePlayer(
        videoPlayerCtr: _controller.videoCtr!,
        videoAspectRatio: widget.videoAspectRatio,
        tag: widget.controller.getTag,
      );
    }
  }
}

class PlayPause extends StatefulWidget {
  final double? size;
  final String tag;

  const PlayPause({
    Key? key,
    this.size,
    required this.tag,
  }) : super(key: key);

  @override
  State<PlayPause> createState() => PlayPauseState();
}

class PlayPauseState extends State<PlayPause>
    with SingleTickerProviderStateMixin {
  late final AnimationController _payCtr;
  @override
  void initState() {
    _payCtr = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    super.initState();
  }

  @override
  void dispose() {
    _payCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final _controller = Get.find<GlorifiVideoGetXController>(tag: widget.tag);
    return GetBuilder<GlorifiVideoGetXController>(
      tag: widget.tag,
      id: 'overlay',
      builder: (_controller) {
        return GetBuilder<GlorifiVideoGetXController>(
          tag: widget.tag,
          id: 'glorifiVideoState',
          builder: (_controller) => MaterialIconButton(
            toolTipMesg: _controller.isvideoPlaying
                ? 'Pause${kIsWeb ? ' (space)' : ''}'
                : 'Play${kIsWeb ? ' (space)' : ''}',
            onPressed: _controller.isOverlayVisible
                ? _controller.togglePlayPauseVideo
                : null,
            child: onStateChange(_controller),
          ),
        );
      },
    );
  }

  Widget onStateChange(GlorifiVideoGetXController _controller) {
    // ignore: always_put_control_body_on_new_line
    if (kIsWeb) return _playPause(_controller);
    if (_controller.glorifiVideoState == GlorifiVideoState.loading) {
      return const SizedBox();
    } else {
      return _playPause(_controller);
    }
  }

  Widget _playPause(GlorifiVideoGetXController _controller) {
    return AnimatedIcon(
      icon: AnimatedIcons.play_pause,
      progress: _controller.playPauseCtr ?? _payCtr,
      color: Colors.white,
      size: widget.size,
    );
  }
}
