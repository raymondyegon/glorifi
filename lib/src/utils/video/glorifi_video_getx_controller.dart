import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:glorifi/src/utils/video/glorifi_video_ui_controller.dart';
import 'package:glorifi/src/utils/video/utils/video_enums.dart';
import 'package:universal_html/html.dart' as _html;
import 'package:video_player/video_player.dart';

import 'models/glorifi_video_player_config.dart';

class GlorifiVideoGetXController extends GlorifiVideoUiController {
  String? fromNetworkUrl;
  bool controllerInitialized = false;

  void config({
    String? fromNetworkUrl,
    required GlorifiVideoPlayerType playerType,
    bool isLooping = false,
    bool autoPlay = true,
    int? vimeoVideoQuality,
  }) {
    this.fromNetworkUrl = fromNetworkUrl;
    videoPlayerType = playerType;
    this.autoPlay = autoPlay;
    this.isLooping = isLooping;
  }

  ///*init
  Future<void> videoInit() async {
    ///
    checkPlayerType();
    log(videoPlayerType.toString());
    try {
      await _initializePlayer();
      await videoCtr?.initialize();
      videoDuration = videoCtr?.value.duration ?? Duration.zero;
      await setLooping(isLooping);
      videoCtr?.addListener(videoListener);
      addListenerId('glorifiVideoState', glorifiVideoStateListener);

      checkAutoPlayVideo();
      controllerInitialized = true;
      update();

      update(['update-all']);
      // ignore: unawaited_futures
      Future.delayed(const Duration(milliseconds: 600))
          .then((value) => isWebAutoPlayDone = true);
    } catch (e) {
      log('ERROR ON FLVIDEOPLAYER:  $e');
      rethrow;
    }
  }

  Future<void> _initializePlayer() async {
    switch (videoPlayerType) {
      case GlorifiVideoPlayerType.network:

        ///
        videoCtr = VideoPlayerController.network(fromNetworkUrl!);

        break;
      case GlorifiVideoPlayerType.auto:
        assert(
          fromNetworkUrl != null,
          '''---------  any one parameter is required  ---------''',
        );
        videoCtr = VideoPlayerController.network(fromNetworkUrl!);
        break;
    }
  }

  Timer? _keyBoardEventTimer;

  ///Listning on keyboard events
  void onKeyBoardEvents({
    required RawKeyEvent event,
    required BuildContext appContext,
    required String tag,
  }) {
    if (kIsWeb) {
      if (event.isKeyPressed(LogicalKeyboardKey.space)) {
        togglePlayPauseVideo();
        return;
      }
      if (event.isKeyPressed(LogicalKeyboardKey.keyM)) {
        toggleMute();
        return;
      }
      if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
        onLeftDoubleTap();
        return;
      }
      if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
        onRightDoubleTap();
        return;
      }
      if (event.logicalKey.debugName == 'Key F') {
        if (_keyBoardEventTimer == null || !_keyBoardEventTimer!.isActive) {
          toggleFullScreenOnWeb();
        }
        _keyBoardEventTimer = Timer(const Duration(milliseconds: 400), () {
          _keyBoardEventTimer?.cancel();
        });

        return;
      }
    }
  }

  void toggleFullScreenOnWeb() {
    if (isFullScreen) {
      _html.document.exitFullscreen();
    } else {
      _html.document.documentElement?.requestFullscreen();
    }
  }

  ///this func will listen to update id `glorifiVideoState`
  void glorifiVideoStateListener() {
    log(glorifiVideoState.toString());
    switch (glorifiVideoState) {
      case GlorifiVideoState.playing:
        playVideo(true);
        break;
      case GlorifiVideoState.paused:
        playVideo(false);
        break;
      case GlorifiVideoState.loading:
        isShowOverlay(true);
        break;
      case GlorifiVideoState.error:
        playVideo(false);
        break;
    }
  }

  ///check video player type
  void checkPlayerType() {
    if (videoPlayerType == GlorifiVideoPlayerType.auto) {
      if (fromNetworkUrl != null) {
        videoPlayerType = GlorifiVideoPlayerType.network;
        return;
      }
      //Default
      videoPlayerType = GlorifiVideoPlayerType.auto;
    }
  }

  void webFullScreenListner(BuildContext context, String tag) {
    ///
    if (kIsWeb) {
      ///this will listen to fullScreen and exitFullScreen state in web
      _html.document.documentElement?.onFullscreenChange.listen(
        (e) {
          if (isFullScreen) {
            exitFullScreenView(context, tag);
          } else {
            enableFullScreenView(context, tag);
          }
        },
      );
    }
  }

  ///checks whether video should be `autoplayed` initially
  void checkAutoPlayVideo() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (autoPlay) {
        // ignore: always_put_control_body_on_new_line
        if (kIsWeb) await videoCtr?.setVolume(0);
        glorifiVideoStateChanger(GlorifiVideoState.playing);
      } else {
        glorifiVideoStateChanger(GlorifiVideoState.paused);
      }
    });
  }

  Future<void> changeVideo(
    GlorifiVideoPlayerType playerType,
    String? fromNetworkUrl,
    GlorifiVideoPlayerConfig playerConfig,
  ) async {
    videoCtr?.removeListener(videoListener);
    glorifiVideoStateChanger(GlorifiVideoState.paused);
    glorifiVideoStateChanger(GlorifiVideoState.loading);
    keyboardFocusWeb?.removeListener(keyboardListener);
    removeListenerId('glorifiVideoState', glorifiVideoStateListener);
    isWebAutoPlayDone = false;
    config(
      playerType: playerType,
      fromNetworkUrl: fromNetworkUrl,
      autoPlay: playerConfig.autoPlay,
      isLooping: playerConfig.isLooping,
    );
    keyboardFocusWeb?.requestFocus();
    keyboardFocusWeb?.addListener(keyboardListener);
    await videoInit();
  }
}
