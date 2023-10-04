import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnboardingBackgroundVideo extends StatefulWidget {
  const OnboardingBackgroundVideo({Key? key}) : super(key: key);

  @override
  _OnboardingBackgroundVideoState createState() =>
      _OnboardingBackgroundVideoState();
}

class _OnboardingBackgroundVideoState extends State<OnboardingBackgroundVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/startup.mp4')
      ..initialize().then((_) {
        // Video has been loaded. Play it with looping
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          child: VideoPlayer(_controller),
          width: _controller.value.size.width,
          height: _controller.value.size.height,
        ),
      ),
    );
  }
}
