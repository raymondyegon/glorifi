import 'package:glorifi/src/utils/video/utils/video_enums.dart';
import 'package:glorifi/src/utils/video/utils/widgets/glorifi_video_progress_bar.dart';

class OverLayOptions {
  final GlorifiVideoState glorifiVideoState;
  final Duration videoDuration;
  final Duration videoPosition;
  final bool isFullScreen;
  final bool isLooping;
  final bool isOverlayVisible;
  final bool isMute;
  final bool autoPlay;
  final String currentVideoPlaybackSpeed;
  final List<String> videoPlayBackSpeeds;
  final GlorifiVideoPlayerType videoPlayerType;
  final GlorifiVideoProgressBar progressBar;
  OverLayOptions({
    required this.glorifiVideoState,
    required this.videoDuration,
    required this.videoPosition,
    required this.isFullScreen,
    required this.isLooping,
    required this.isOverlayVisible,
    required this.isMute,
    required this.autoPlay,
    required this.currentVideoPlaybackSpeed,
    required this.videoPlayBackSpeeds,
    required this.videoPlayerType,
    required this.progressBar,
  });
}
