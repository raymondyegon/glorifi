import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../glorifi_video_getx_controller.dart';
import 'core/glorifi_core_player.dart';

class FullScreenView extends StatefulWidget {
  final String tag;
  const FullScreenView({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView>
    with TickerProviderStateMixin {
  late GlorifiVideoGetXController _controller;
  @override
  void initState() {
    _controller = Get.find<GlorifiVideoGetXController>(tag: widget.tag);
    _controller.keyboardFocusWeb?.removeListener(_controller.keyboardListener);
    _controller
      ..enableFullScreen()
      ..playPauseCtr = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 450),
      );
    if (_controller.isvideoPlaying) {
      _controller.playPauseCtr?.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.keyboardFocusWeb?.requestFocus();
    _controller.keyboardFocusWeb?.addListener(_controller.keyboardListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const circularProgressIndicator = CircularProgressIndicator(
      backgroundColor: Colors.black87,
      color: Colors.white,
      strokeWidth: 2,
    );
    return WillPopScope(
      onWillPop: () async {
        await _controller.disableFullScreen();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<GlorifiVideoGetXController>(
          tag: widget.tag,
          builder: (_controller) => Center(
            child: ColoredBox(
              color: Colors.black,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: _controller.videoCtr == null
                      ? circularProgressIndicator
                      : _controller.videoCtr!.value.isInitialized
                          ? GlorifiCorePlayer(
                              tag: widget.tag,
                              videoPlayerCtr: _controller.videoCtr!,
                              videoAspectRatio:
                                  _controller.videoCtr?.value.aspectRatio ??
                                      16 / 9,
                            )
                          : circularProgressIndicator,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
