import 'package:contentful/client.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/environment/environment.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/stories_prefab.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/services/content_service.dart';
import 'package:glorifi/src/services/story_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/video/glorifi_video_controller.dart';
import 'package:glorifi/src/utils/video/models/glorifi_video_player_config.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class StoryController extends BaseController {
  final stories = [].obs;

  bool get fetchedLastStory =>
      stories.length > 0 &&
      [StoryType.LastStory].contains(stories[stories.length - 1].type);

  RxBool _isLocked = false.obs;

  bool get isLocked => _isLocked.value;
  RxBool _isWeb = false.obs;

  bool get isWeb => _isWeb.value;

  RxBool _isRefresh = false.obs;

  bool get isRefresh => _isRefresh.value;

  RxBool _isServerFailure = false.obs;

  bool get isServerFailure => _isServerFailure.value;

  final int retryCount = 2;

  final config = Environment().config;

  final storiesPerPage = 10;

  GlorifiVideoController videoController = GlorifiVideoController(
    fromNetworkUrl:
        'https://cdn-glorifi-video.azureedge.net/glorifi_tis_of_thee_v24.mp4',
    playerConfig: const GlorifiVideoPlayerConfig(
      autoPlay: false),
  )..initialise();

  late YoutubePlayerController youtubeController;

  List get webStories => stories
      .where((element) => ![
            StoryType.SecondaryArticle,
            StoryType.SecondaryVideo
          ].contains(element.type))
      .toList();

  @override
  void onInit() {
    _fetchStories();
    super.onInit();
  }

  setIsWeb() {
    _isWeb(true);
  }

  refreshStories({bool saveFirst: false}) async {
    if (saveFirst) {
      stories.removeRange(1, stories.length);
    } else {
      stories.clear();
    }
    await loadStories(0, clear: true);
  }

  clearAndRefresh(response) async {
    _isRefresh(true);
    await Future.delayed(Duration(milliseconds: 500));
    stories.clear();
    _isRefresh(false);
    response.forEach(stories.add);
  }

  loadStories(index, {bool clear: false}) async {
    // must lock before calling
    getStories(int index) async {
      int retries = 0;
      while (retries < retryCount) {
        List<dynamic>? response =
            await StoryService().getNextStory(index, storiesPerPage);
        if (response != null) {
          if (clear) {
            clearAndRefresh(response);
          } else {
            response.forEach(stories.add);
          }
          break;
        }
        retries++;
      }
    }

    while (isLocked) {
      await Future.delayed(const Duration(milliseconds: 10), () {});
    }
    if (fetchedLastStory && !clear) {
      return;
    }

    _isLocked(true);
    if (clear) {
      await getStories(0);
    } else {
      while (stories.length <= index + (storiesPerPage * 2) || isWeb) {
        if (fetchedLastStory) {
          break;
        }
        await getStories(stories.length);
      }
    }
    _isLocked(false);
  }

  getInternalArticle(String contentId) async {
    final contentClient = Client(
      BearerTokenHTTPClient(config.contentfulAPIKey),
      spaceId: config.contentfulSpacerID,
    );
    try {
      final collection = await contentClient.getEntry(contentId, (p0) {
        return p0;
      });
      return collection;
    } catch (e) {
      e.printError();
    }
  }

  viewedContent(String contentId) async {
    await ContentService().viewedContent(contentId);
  }

  _initYouTubeController(String youtubeId) async {
    youtubeController = YoutubePlayerController(
        initialVideoId: youtubeId,
        params:
            YoutubePlayerParams(showFullscreenButton: true, autoPlay: true));

    youtubeController.listen((event) {
      // add this because I couldn't get it to play elsewhere
      if ([PlayerState.unknown, PlayerState.unStarted, PlayerState.buffering]
              .contains(event.playerState) &&
          event.isReady) {
        youtubeController.play();
      }
    });

    youtubeController.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    };
    youtubeController.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    };
  }

  playYoutubeVideo(String youtubeId) {
    _initYouTubeController(youtubeId);
  }

  pauseVideo() {
    youtubeController.pause();
  }

  _fetchStories() async {
    await loadStories(0);

    // var articleModel = ArticleStoryModel(
    //   imageUrl:
    //       'https://static.timesofisrael.com/www/uploads/2022/03/AP22067306432734.jpg',
    //   backgroundImage:
    //       'https://images.unsplash.com/photo-1484387436194-cf7cb70800ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGFyayUyMG9jZWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    //   duration: 2,
    //   content:
    //       "Lorem ipsum dolor sit amet, consectetur adipisasdfasdfasfsdfasdfadscing elit.et, euismod aliquet lacus tortor nibh neque. Aliquet sed id cras commodo. Id pretiet, euismod aliquet lacus tortor nibh neque. Aliquet sed id cras commodo. Id pretiet, euismod aliquet lacus tortor nibh neque. Aliquet sed id cras commodo. Id pretiet, euismod aliquet lacus tortor nibh neque. Aliquet sed id cras commodo. Id preti Cursus amet, euismod aliquet lacus tortor nibh neque. Aliquet sed id cras commodo. Id pretium cras vivamus nulla fermentum eu diam sit in. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus amet, euismod aliquet lacus tortor nibh neque. Aliquet sed id cras commodo. Id pretium cras vivamus nulla fermentum eu diam sit in. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus amet, euismod aliquet lacus tortor nibh neque. Aliquet sed id cras commodo. Id pretium cras vivamus nulla fermentum eu diam sit in. ",
    //   // route: Routes.featuredArticle,
    //   source: 'Fox sdfsdfsfsdfNews',
    //   headline:
    //       'asdfasdfasfasdfasdfasdfasdfasdfasfsasdfdasFed\'s Bullard says interest rates need to rise above 3% to quell inflation',
    //   author: 'Weston Berchams',
    //   publishDate: DateTime.now(),
    // );

    // stories.add(articleModel);
    // stories.add(ProductStoryModel(productType: StoryProductTypes.creditCard));
    // stories.add(ProductStoryModel(productType: StoryProductTypes.heroBundle));
    // stories
    //     .add(ProductStoryModel(productType: StoryProductTypes.homefrontBundle));
    // stories
    //     .add(ProductStoryModel(productType: StoryProductTypes.protectBundle));

    // var videoModel = VideoStoryModel(
    //     duration: null,
    //     headline:
    //         'Fed\'s Bullard says interest rates need to rise above 3% to quell inflsdfasdfasdfadsfasdfadsfdsation',
    //     imageUrl:
    //         'https://static.timesofisrael.com/www/uploads/2022/03/AP22067306432734.jpg',
    //     backgroundImage:
    //         'https://images.unsplash.com/photo-1484387436194-cf7cb70800ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGFyayUyMG9jZWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    //     source: 'CBsdfsdfsdfdsfsfS',
    //     videoUrl: "14XxolEJloE");

    // stories.add(articleModel);
    // stories.add(videoModel);

    // stories.add(StoryModel(
    //   type: StoryType.GloriFiStory,
    //   backgroundImage: 'assets/images/glorifi_story.png',
    // ));

    // stories.add(MultiVideoStoryModel(
    //     hero: videoModel, secondary: [videoModel, videoModel]));

    // stories.add(MultiArticleStoryModel(
    //     hero: articleModel, secondary: [articleModel, articleModel]));
    // StoryModel(type: StoryType.Product);

    // stories.add(FactStoryModel(
    //   backgroundImage:
    //       "https://glorifi-test-wp.azurewebsites.net/wp-content/uploads/2022/02/1839-samuel-colt-paterson-revolver-patent-print-gray-greg-edwards.jpeg",
    //   fact:
    //       "Samuel Colt had the inspiration for his famous revolver when he was 16 years old.",
    // ));
    // stories.add(StoryModel(type: StoryType.Invite));

    // stories.add(QuoteStoryModel(
    //     author: '— Ronald Reagan',
    //     quote:
    //         'When you can\'t make them see the light, make them feel the heat.',
    //     backgroundImage:
    //         'https://media.istockphoto.com/photos/blue-sky-and-white-clouds-background-picture-id825778252?k=20&m=825778252&s=612x612&w=0&h=i5tqMrPeAshcGZ_Clma9t_wp9rIw1bkm0gdz2ozR7OQ='));
    // stories.add(StoryModel(type: StoryType.Product));

    //todo need to call this method after getting response from API
    // _addLstStory();
  }

// _addLstStory() {
//   stories.add(LastStoryModel(
//     message:
//         "You’re all caught up for the day. Check out your financial snapshot.",
//   ));
//  }
}
