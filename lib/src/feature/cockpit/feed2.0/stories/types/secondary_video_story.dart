import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_secondary_content_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';

class SecondaryVideoStory extends StatelessWidget {
  final MultiVideoStoryModel story;

  const SecondaryVideoStory(
      {Key? key, required MultiVideoStoryModel this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSecondaryContentStory(
        story: story, contentType: StoryContentType.Video);
  }
}
