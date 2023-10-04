// ignore_for_file: always_put_control_body_on_new_line

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:glorifi/src/utils/video/utils/video_enums.dart';
import 'package:video_player/video_player.dart';

class GlorifiVideoBaseController extends GetxController {
  ///main video controller
  VideoPlayerController? videoCtr;

  ///
  late GlorifiVideoPlayerType videoPlayerType;

  bool isMute = false;
  FocusNode? keyboardFocusWeb;

  bool autoPlay = true;
  bool isWebAutoPlayDone = false;

  ///
  GlorifiVideoState glorifiVideoState = GlorifiVideoState.loading;

  ///
  bool isWebPopupOverlayOpen = false;

  ///
  Duration videoDuration = Duration.zero;

  Duration videoPosition = Duration.zero;

  String currentPaybackSpeed = 'Normal';

  ///**listeners

  Future<void> videoListener() async {
    if (!videoCtr!.value.isInitialized) {
      await videoCtr!.initialize();
    }
    if (videoCtr!.value.isInitialized) {
      _listenToVideoState();
      _listenToVideoPosition();
      _listenToVolume();
      if (kIsWeb && autoPlay && isMute && !isWebAutoPlayDone) _webAutoPlay();
    }
  }

  void _webAutoPlay() => videoCtr!.setVolume(1);

  void _listenToVolume() {
    if (videoCtr!.value.volume == 0) {
      if (!isMute) {
        isMute = true;
        update(['volume']);
        update(['update-all']);
      }
    } else {
      if (isMute) {
        isMute = false;
        update(['volume']);
        update(['update-all']);
      }
    }
  }

  void _listenToVideoState() {
    glorifiVideoStateChanger(
      videoCtr!.value.isBuffering || !videoCtr!.value.isInitialized
          ? GlorifiVideoState.loading
          : videoCtr!.value.isPlaying
              ? GlorifiVideoState.playing
              : GlorifiVideoState.paused,
    );
  }

  ///updates state with id `glorifiVideoState`
  void glorifiVideoStateChanger(GlorifiVideoState? _val) {
    if (glorifiVideoState != (_val ?? glorifiVideoState)) {
      glorifiVideoState = _val ?? glorifiVideoState;
      update(['glorifiVideoState']);
      update(['update-all']);
    }
  }

  void _listenToVideoPosition() {
    if ((videoCtr?.value.duration.inSeconds ?? Duration.zero.inSeconds) < 60) {
      videoPosition = videoCtr?.value.position ?? Duration.zero;
      update(['video-progress']);
      update(['update-all']);
    } else {
      if (videoPosition.inSeconds !=
          (videoCtr?.value.position ?? Duration.zero).inSeconds) {
        videoPosition = videoCtr?.value.position ?? Duration.zero;
        update(['video-progress']);
        update(['update-all']);
      }
    }
  }

  void keyboardListener() {
    if (keyboardFocusWeb != null && !keyboardFocusWeb!.hasFocus) {
      if (keyboardFocusWeb!.canRequestFocus) {
        keyboardFocusWeb!.requestFocus();
      }
    }
  }
}
