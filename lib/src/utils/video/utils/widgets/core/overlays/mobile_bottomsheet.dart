import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../glorifi_video_getx_controller.dart';

class MobileBottomSheet extends StatelessWidget {
  final String tag;

  const MobileBottomSheet({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlorifiVideoGetXController>(
      tag: tag,
      builder: (_controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _bottomSheetTiles(
            title: 'Loop video',
            icon: Icons.loop_rounded,
            subText: _controller.isLooping ? 'On' : 'Off',
            onTap: () {
              Navigator.of(context).pop();
              _controller.toggleLooping();
            },
          ),
          _bottomSheetTiles(
              title: 'Playback speed',
              icon: Icons.slow_motion_video_rounded,
              subText: _controller.currentPaybackSpeed,
              onTap: () {
                Navigator.of(context).pop();
                Timer(const Duration(milliseconds: 100), () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) =>
                          _VideoPlaybackSelectorMob(tag: tag));
                });
              }),
        ],
      ),
    );
  }

  ListTile _bottomSheetTiles({
    required String title,
    required IconData icon,
    String? subText,
    void Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      onTap: onTap,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            if (subText != null) const SizedBox(width: 6),
            if (subText != null)
              const SizedBox(
                height: 4,
                width: 4,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                )),
              ),
            if (subText != null) const SizedBox(width: 6),
            if (subText != null)
              Text(
                subText,
                style: const TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoPlaybackSelectorMob extends StatelessWidget {
  final void Function()? onTap;
  final String tag;

  const _VideoPlaybackSelectorMob({
    Key? key,
    this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GlorifiVideoGetXController>(tag: tag);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: controller.videoPlaybackSpeeds
            .map(
              (e) => ListTile(
                title: Text(
                  e,
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  onTap != null ? onTap!() : Navigator.of(context).pop();
                  controller.setVideoPlayBack(e);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
