import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/video/utils/video_enums.dart';
import 'package:video_player/video_player.dart';

import 'glorifi_video_getx_controller.dart';
import 'models/glorifi_video_player_config.dart';

class GlorifiVideoController {
  ///
  late GlorifiVideoGetXController _ctr;
  late String getTag;
  bool _isInitialised = false;
  final GlorifiVideoPlayerType playerType;
  final String? fromNetworkUrl;
  final GlorifiVideoPlayerConfig playerConfig;
  GlorifiVideoController({
    this.playerType = GlorifiVideoPlayerType.auto,
    this.fromNetworkUrl,
    this.playerConfig = const GlorifiVideoPlayerConfig(),
  }) {
    getTag = UniqueKey().toString();
    _ctr = Get.put(GlorifiVideoGetXController(), permanent: true, tag: getTag)
      ..config(
        playerType: playerType,
        fromNetworkUrl: fromNetworkUrl,
        autoPlay: playerConfig.autoPlay,
        isLooping: playerConfig.isLooping,
      );
  }
  //!init
  Future<void> initialise() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await _ctr.videoInit();
    });
    await _checkAndWaitTillInitialized();
  }

  Future<void> _checkAndWaitTillInitialized() async {
    if (_ctr.controllerInitialized) {
      _isInitialised = true;
      return;
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
      await _checkAndWaitTillInitialized();
    }
  }

  bool get isInitialised => _ctr.videoCtr?.value.isInitialized ?? false;
  bool? get isVideoPlaying => _ctr.videoCtr?.value.isPlaying;
  bool? get isVideoBuffering => _ctr.videoCtr?.value.isBuffering;
  bool? get isVideoLooping => _ctr.videoCtr?.value.isLooping;

  VideoPlayerValue? get videoPlayerValue => _ctr.videoCtr?.value;

  GlorifiVideoPlayerType get videoPlayerType => _ctr.videoPlayerType;

  // Future<void> initialize() async => _ctr.videoCtr?.initialize;

  //! video positions

  ///return total length of the video
  Duration get totalVideoLength => _ctr.videoDuration;

  ///return current position/duration of the video
  Duration get currentVideoPosition => _ctr.videoPosition;

  //! video play/pause

  void play() => _ctr.glorifiVideoStateChanger(GlorifiVideoState.playing);

  void pause() => _ctr.glorifiVideoStateChanger(GlorifiVideoState.paused);

  //! volume Controllers

  Future<void> mute() async => _ctr.mute();

  Future<void> unMute() async => _ctr.unMute();

  ///Dispose controller
  void dispose() {
    _ctr.videoCtr?.removeListener(_ctr.videoListener);
    _ctr.videoCtr?.dispose();
    _ctr.removeListenerId('glorifiVideoState', _ctr.glorifiVideoStateListener);
    Get.delete<GlorifiVideoGetXController>(
      force: true,
      tag: getTag,
    );
  }

  Future<void> changeVideo({
    GlorifiVideoPlayerType playerType = GlorifiVideoPlayerType.auto,
    String? fromNetworkUrl,
    GlorifiVideoPlayerConfig playerConfig = const GlorifiVideoPlayerConfig(),
  }) {
    if (fromNetworkUrl == _ctr.fromNetworkUrl) {
      _ctr.seekTo(Duration(minutes: 0));
      return _ctr.playVideo(playerConfig.autoPlay);
    } else {
      return _ctr.changeVideo(
        playerType,
        fromNetworkUrl,
        playerConfig,
      );
    }
  }

  ///Jumps to specific position of the video
  Future<void> videoStartsFrom(Duration moment) async {
    await _checkAndWaitTillInitialized();
    // ignore: always_put_control_body_on_new_line
    if (!_isInitialised) return;
    return _ctr.seekTo(moment);
  }

  ///Movies video forward from current duration to `_duration`
  Future<void> videoSeekForward(Duration _duration) async {
    await _checkAndWaitTillInitialized();
    // ignore: always_put_control_body_on_new_line
    if (!_isInitialised) return;
    return _ctr.seekForward(_duration);
  }

  ///Movies video backward from current duration to `_duration`
  Future<void> videoSeekBackward(Duration _duration) async {
    await _checkAndWaitTillInitialized();
    // ignore: always_put_control_body_on_new_line
    if (!_isInitialised) return;
    return _ctr.seekBackward(_duration);
  }
// ignore: todo
//TODO: support for playlist
}
