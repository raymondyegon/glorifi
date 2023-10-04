import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_secondary_content_story.dart';

class SecondaryArticleStory extends StatelessWidget {
  final MultiArticleStoryModel story;

  const SecondaryArticleStory(
      {Key? key, required MultiArticleStoryModel this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSecondaryContentStory(
        story: story, contentType: StoryContentType.Article);
  }
}
