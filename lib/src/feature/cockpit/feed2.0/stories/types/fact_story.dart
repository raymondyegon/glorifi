import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class FactStory extends StatelessWidget {
  final FactStoryModel story;

  const FactStory({Key? key, required FactStoryModel this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStory(
      // TODO:
      child: Stack(
        children: [
          Center(
            child: Image.network(
              story.backgroundImage!,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.75),
                      Colors.white,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ])),
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: story.fact,
                style: headlineRegular31Secondary(
                    color: GlorifiColors.darkBlueColor),
              ),
            ).paddingAll(25),
          ),
          Positioned(
              top: 50,
              right: 25,
              child: Text(
                "Fact of the Day",
                style:
                    smallBold16Primary(color: GlorifiColors.blueMidnightBlue),
              )),
        ],
      ),
    );
  }
}
