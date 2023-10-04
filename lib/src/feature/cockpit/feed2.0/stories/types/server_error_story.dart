import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/header.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

// TODO: This isn't being used anymore
class ServerErrorStory extends GetView<StoryController> {
  final bool isFirstStory;

  const ServerErrorStory({Key? key, required this.isFirstStory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _message = Container(
        height: 1.sh,
        width: 1.sw,
        padding: EdgeInsets.all(20.w),
        color: isFirstStory == true
            ? Colors.transparent
            : GlorifiColors.midnightBlue,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sorry, that content can’t be displayed right now.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: GlorifiColors.white,
                    fontSize: 31,
                    fontFamily: 'univers'),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                isFirstStory
                    ? "Pull down to refresh the page"
                    : "Continue scrolling.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: GlorifiColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]));

    if (isFirstStory) {
      return Header(
        child: _message,
      );
    }
    return _message;
  }
}
