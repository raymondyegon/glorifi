import 'package:glorifi/src/feature/bundles/model/bundle_type.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';

extension StoryPrefabs on StoryModel {
  static StoryModel LastStory = LastStoryModel(
    message:
        "You’re all caught up for the day. Check out your financial snapshot.",
  );

  static StoryModel Referral =
      StoryModel(type: StoryType.Invite, route: Routes.referral);

  static StoryModel GlorifiStory = StoryModel(
    type: StoryType.GloriFiStory,
    backgroundImage:
        'https://core-assets.azureedge.net/assets/images/glorifi-story.png',
  );
}

extension BundleStoryPrefabs on BundleModel {
  static BundleModel HomeFrontBundle = BundleModel(
      route: Routes.bundlesScreen,
      bundleType: BundleType.HomeFront,
      image: 'assets/images/homefront.png',
      options: [
        "Checking  Account",
        "Savings Account",
        "Brass Credit Card",
        "Home & GloriFi\nShield Insurance"
      ],
      title: 'Homefront');

  static BundleModel HerosBundle = BundleModel(
      route: Routes.bundlesScreen,
      bundleType: BundleType.Heroes,
      image: 'assets/images/heros.png',
      options: ["Checking  Account", "Savings Account", "NewCo Credit Card"],
      title: 'Heroes');

  static BundleModel ProtectBundle = BundleModel(
      route: Routes.bundlesScreen,
      bundleType: BundleType.Protect,
      image: 'assets/images/protect.png',
      options: [
        "Home & GloriFi\nShield Insurance",
        "Auto Insurance",
        "NewCo Credit Card"
      ],
      title: 'Protect');
}
