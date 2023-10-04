import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/stories_prefab.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/banking_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/bundle_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/credit_card_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/fact_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/insurance_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/invite_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/secondary_article_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/secondary_video_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/featured_article_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/featured_video_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/glorifi_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/last_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/quote_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/server_error_story.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';

class Story extends StatelessWidget {
  Story({
    Key? key,
    required StoryModel this.story,
    this.isFirstStory = false,
  }) : super(key: key);

  final StoryModel story;
  final bool isFirstStory;

  @override
  Widget build(BuildContext context) {
    Widget _story(story) {
      switch (story.type) {
        case StoryType.GloriFiStory:
          return GlorifiStory(story: story, isFirstStory: isFirstStory);
        case StoryType.FeaturedVideo:
          return FeaturedVideoStory(story: story, isFirstStory: isFirstStory);
        case StoryType.FeaturedArticle:
          return FeaturedArticleStory(story: story, isFirstStory: isFirstStory);
        case StoryType.Invite:
          return InviteStory(story: story);
        case StoryType.Fact:
          return FactStory(story: story);
        case StoryType.SecondaryArticle:
          return SecondaryArticleStory(story: story);
        case StoryType.SecondaryVideo:
          return SecondaryVideoStory(story: story);
        case StoryType.Quote:
          return QuoteStory(story: story);
        case StoryType.Product:
          switch (story.productType) {
            case StoryProductTypes.creditCard:
              return CreditStory();
            case StoryProductTypes.banking:
              return BankingStory();
            case StoryProductTypes.insurance:
              return InsuranceStory();
            case StoryProductTypes.heroBundle:
              // TODO: Find a better way to feature flag this
              return FeatureFlagManager.bundlesEnabled
                  ? BundleStory(bundleModel: BundleStoryPrefabs.HerosBundle)
                  : Container();
            case StoryProductTypes.homefrontBundle:
              return FeatureFlagManager.bundlesEnabled
                  ? BundleStory(bundleModel: BundleStoryPrefabs.HomeFrontBundle)
                  : Container();
            case StoryProductTypes.protectBundle:
              return FeatureFlagManager.bundlesEnabled
                  ? BundleStory(bundleModel: BundleStoryPrefabs.ProtectBundle)
                  : Container();
            default:
              return Container();
          }
        case StoryType.LastStory:
          return LastStory(story: story);
        case StoryType.ServerError:
          return ServerErrorStory(isFirstStory: isFirstStory);
        default:
          return Container();
      }
    }

    return _story(story);
  }
}
