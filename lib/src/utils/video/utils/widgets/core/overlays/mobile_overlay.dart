import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../glorifi_video_player.dart';
import '../../../../glorifi_video_getx_controller.dart';
import '../../material_icon_button.dart';
import '../video_gesture_detector.dart';
import 'mob_bottom_overlay_controller.dart';
import 'mobile_bottomsheet.dart';

class MobileOverlay extends StatelessWidget {
  final String tag;

  const MobileOverlay({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const overlayColor = Colors.black38;
    const itemColor = Colors.white;
    final controller = Get.find<GlorifiVideoGetXController>(tag: tag);
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: VideoGestureDetector(
                tag: tag,
                onDoubleTap: controller.onLeftDoubleTap,
                child: ColoredBox(
                  color: overlayColor,
                  child: _LeftRightDoubleTapBox(
                    tag: tag,
                    isLeft: true,
                  ),
                ),
              ),
            ),
            VideoGestureDetector(
              tag: tag,
              child: ColoredBox(
                color: overlayColor,
                child: SizedBox(
                  height: double.infinity,
                  child: Center(
                    child: PlayPause(tag: tag, size: 42),
                  ),
                ),
              ),
            ),
            Expanded(
              child: VideoGestureDetector(
                tag: tag,
                onDoubleTap: controller.onRightDoubleTap,
                child: ColoredBox(
                  color: overlayColor,
                  child: _LeftRightDoubleTapBox(
                    tag: tag,
                    isLeft: false,
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialIconButton(
                  toolTipMesg: 'More',
                  color: itemColor,
                  onPressed: () {
                    if (controller.isOverlayVisible) {
                      _bottomSheet(context);
                    } else {
                      controller.toggleVideoOverlay();
                    }
                  },
                  child: const Icon(
                    Icons.more_vert_rounded,
                  ),
                ),
              ],
            ),
            MobileOverlayBottomControllers(tag: tag)
          ],
        ),
      ],
    );
  }

  void _bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MobileBottomSheet(tag: tag),
    );
  }
}

class _LeftRightDoubleTapBox extends StatelessWidget {
  final String tag;
  final bool isLeft;
  const _LeftRightDoubleTapBox({
    Key? key,
    required this.tag,
    required this.isLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlorifiVideoGetXController>(
      tag: tag,
      id: 'double-tap',
      builder: (controller) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: controller.isLeftDbTapIconVisible && isLeft
                ? 1
                : controller.isRightDbTapIconVisible && !isLeft
                    ? 1
                    : 0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset(
                    isLeft
                        ? 'assets/json/forward_left.json'
                        : 'assets/json/forward_right.json',
                  ),
                  if (isLeft
                      ? controller.isLeftDbTapIconVisible
                      : controller.isRightDbTapIconVisible)
                    Transform.translate(
                      offset: const Offset(0, 40),
                      child: Text(
                        '${controller.isLeftDbTapIconVisible ? controller.leftDoubleTapduration : controller.rightDubleTapduration} Sec',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
