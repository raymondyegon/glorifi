import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  static const routeName = '/onboard-video';
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  Future<void> _setupChewie() async {
    _controller = VideoPlayerController.asset('assets/video/Together.mp4');
    await _controller.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      fullScreenByDefault: true,
      autoPlay: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _setupChewie(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Card(
              child: Stack(
                children: [
                  Chewie(controller: _chewieController),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
