import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class QuoteStory extends StatelessWidget {
  final QuoteStoryModel story;

  const QuoteStory({Key? key, required QuoteStoryModel this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStory(
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (story.backgroundImage != null)
            CachedNetworkImage(
              imageUrl: story.backgroundImage!,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.quote,
                  style: headlineRegular32Secondary(
                    color: GlorifiColors.cornflowerBlue,
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  story.author,
                  style: smallSemiBold16Primary(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32.h + MediaQuery.of(context).padding.top,
            right: 24.w,
            child: Text(
              'Quote of the day',
              style: smallBold16Primary(
                color: GlorifiColors.midnightBlueColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
