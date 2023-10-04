import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/video_modal.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_featured_content_story.dart';

class FeaturedVideoStory extends GetView<StoryController> {
  final VideoStoryModel story;
  final bool isFirstStory;

  const FeaturedVideoStory(
      {Key? key, required VideoStoryModel this.story, required this.isFirstStory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStory(
        child: BaseFeaturedContentStory(
            contentType: StoryContentType.Video,
            backgroundImageURL: story.backgroundImage,
            story: story,
            playButton: true,
            modal: VideoModal(),
            onTap: () {
              controller.playYoutubeVideo(story.videoUrl);
              controller.viewedContent(story.contentId);
            },
            isFirstStory: isFirstStory));
  }
}
