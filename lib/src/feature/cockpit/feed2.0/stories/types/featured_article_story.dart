import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/external_article_modal.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_featured_content_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/article_modal.dart';

class FeaturedArticleStory extends GetView<StoryController> {
  final ArticleStoryModel story;
  final bool isFirstStory;

  FeaturedArticleStory(
      {Key? key, required ArticleStoryModel this.story, required this.isFirstStory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStory(
        child: BaseFeaturedContentStory(
            modal: story.url == null
                ? ArticleModal(data: story)
                : ExternalArticleModal(
                    url: story.url!,
                    isWeb: controller.isWeb,
                  ),
            onTap: () {
              controller.viewedContent(story.contentId);
            },
            isFirstStory: isFirstStory,
            contentType: StoryContentType.Article,
            story: story,
            backgroundImageURL: story.backgroundImage));
  }
}
