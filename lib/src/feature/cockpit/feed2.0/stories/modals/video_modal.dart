import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/base_modal.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/app_lock/app_lock_watchdog_service.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/video/glorifi_video_player.dart';
import 'package:glorifi/src/widgets/buttons/close_modal_button.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class VideoModal extends StatefulWidget {
  final bool isYouTube;
  const VideoModal({
    Key? key,
    this.isYouTube = true,
  }) : super(key: key);

  @override
  State<VideoModal> createState() => _VideoModalState();
}

class _VideoModalState extends State<VideoModal> {
  Timer? timer;
  AppLockWatchdogService get appLockService =>
      Get.find<AppLockWatchdogService>();
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 60), (Timer t) => appLockService.resetCountdown());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    timer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StoryController controller = Get.find<StoryController>();
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.isNativeMobile || sizingInfo.isWebMobile) {
        return _mobile(controller);
      } else {
        return _desktop(controller);
      }
    });
  }

  Widget _video(controller, aspectRatio) {
    return Center(
            child: widget.isYouTube
                ? YoutubePlayerIFrame(
                    controller: controller.youtubeController,
              aspectRatio: aspectRatio,
                  )
                : GlorifiVideoPlayer(
                    controller: controller.videoController,
            ),      
    );
  }

  Widget _desktop(controller) {
    return InkWell(
      child: Container(
          width: 1.sw,
          color: GlorifiColors.ebonyBlue.withOpacity(0.97),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 995,
                  alignment: Alignment.centerRight,
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      "Close",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(
                      Icons.close,
                      color: Colors.white,
                    )
                  ]),
                ).paddingOnly(bottom: 10),
                Container(width: 995, child: _video(controller, 16 / 9))
              ])),
      onTap: () {
        widget.isYouTube ? controller.pauseVideo() : controller.videoController.pause();
        Navigator.of(context).pop();
      },
    );
  }

  Widget _mobile(controller) {
    return OrientationBuilder(builder: (context, orientation) {
      return Container(
          height: 1.sh,
          color: GlorifiColors.black,
          child: Stack(fit: StackFit.expand, children: [
            _video(controller, orientation == Orientation.portrait ? 9 / 12 : 16 / 9),
            Container(
            height: 1.sh,
            child: CloseModalButton(
              onTap: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);
                widget.isYouTube
                    ? controller.pauseVideo()
                    : controller.videoController.pause();
              },
            ),
            alignment: Alignment.topLeft,
          ),
          ]));
    });
  
  }
}
