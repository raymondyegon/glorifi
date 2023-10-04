import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final double height;

  const PlayButton({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: Align(
            alignment: Alignment.center,
            child: Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.2), shape: BoxShape.circle),
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white.withOpacity(0.5),
                size: height - 20,
              ),
            )));
  }
}
