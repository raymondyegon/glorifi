import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/video_controller.dart';
import 'package:glorifi/src/utils/video/glorifi_video_player.dart';

class VideoPlayerDemo extends GetView<VideoController> {
  const VideoPlayerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            GlorifiVideoPlayer(
              controller: controller.controller,
            ),
            TextButton(onPressed: () {}, child: Text('Haii')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            controller.controller.unMute();
          },
        ));
  }
}
