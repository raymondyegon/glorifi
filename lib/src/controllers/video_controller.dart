import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/video/glorifi_video_controller.dart';
import 'package:glorifi/src/utils/video/models/glorifi_video_player_config.dart';

class VideoController extends BaseController {
  late GlorifiVideoController controller;
  @override
  void onInit() {
    super.onInit();
    controller = GlorifiVideoController(
      fromNetworkUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      playerConfig: const GlorifiVideoPlayerConfig(forcedVideoFocus: true),
    )..initialise();
  }
}
