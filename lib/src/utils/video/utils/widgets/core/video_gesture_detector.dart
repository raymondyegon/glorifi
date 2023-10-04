import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../glorifi_video_getx_controller.dart';

class VideoGestureDetector extends StatelessWidget {
  final Widget? child;
  final void Function()? onDoubleTap;
  final void Function()? onTap;
  final String tag;

  const VideoGestureDetector({
    Key? key,
    this.child,
    this.onDoubleTap,
    this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<GlorifiVideoGetXController>(tag: tag);
    return MouseRegion(
      onHover: (event) => _controller.onOverlayHover(),
      onExit: (event) => _controller.onOverlayHoverExit(),
      child: GestureDetector(
        onTap: onTap ?? _controller.toggleVideoOverlay,
        onDoubleTap: onDoubleTap,
        child: child,
      ),
    );
  }
}
