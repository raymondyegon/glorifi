import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/greeting/greeting.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/loader/indicator.dart';
import 'package:glorifi/src/widgets/loading/blue_background.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

var webStoryHeight = {
  StoryType.GloriFiStory: 624.0.h,
  StoryType.FeaturedVideo: 311.0.h,
  StoryType.FeaturedArticle: 311.0.h,
  StoryType.Invite: 300.0.h,
  StoryType.Fact: 500.0.h,
  StoryType.SecondaryArticle: 1000.0.h,
  StoryType.SecondaryVideo: 1000.0.h,
  StoryType.Quote: 750.0.h,
  StoryType.Product: 750.0.h,
  StoryType.LastStory: 318.0.h,
};

class TodayFeed extends StatefulWidget {
  TodayFeed({Key? key}) : super(key: key);

  @override
  State<TodayFeed> createState() => _TodayFeedState();
}

class _TodayFeedState extends State<TodayFeed> {
  bool pause = false;

  _TodayFeedState() {
    Get.lazyPut(() => StoryController());
  }

  StoryController get storyController => Get.find<StoryController>();
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  var webColumnStories = [StoryType.Fact, StoryType.Quote, StoryType.Product];

  @override
  Widget build(BuildContext context) {
    pullToRefresh() async {
      setState(() {
        pause = true;
      });
      pageController.jumpToPage(0);
      await storyController.refreshStories(saveFirst: true);
      setState(() {
        pause = false;
      });
    }

    Widget _story(index) {
      Widget _scrollToTop = GestureDetector(
        onTap: () {
          pageController.animateTo(0.0,
              duration: Duration(seconds: 1), curve: Curves.ease);
        },
        child: SizedBox(
          width: 1.sw,
          height: 80.h,
          child: Text(""),
        ),
      );

      return Obx(() => storyController.isRefresh
          ? BlueBackground(
              addHeader: true,
              addSpinner: false,
            )
          : Container(
              color: GlorifiColors.productsBgWhite,
              child: Stack(children: [
                Story(
                  story: storyController.stories[index],
                  isFirstStory: index == 0,
                ),
                if (index != 0) _scrollToTop
              ]),
            ));
    }

    Widget pageView = Obx(
      () => GlorifiIndicator(
        onRefresh: pullToRefresh,
        child: Container(
            color: GlorifiColors.midnightBlue,
            child: PageView.builder(
              allowImplicitScrolling: true,
              controller: pageController,
              scrollDirection: Axis.vertical,
              scrollBehavior: AppScrollBehavior(),
              physics: pause
                  ? NeverScrollableScrollPhysics()
                  : _CustomPageViewScrollPhysics(),
              onPageChanged: (int index) async {
                await storyController.loadStories(index);
              },
              itemBuilder: (context, index) {
                return _story(index);
              },
              itemCount: storyController.stories.length,
            )),
      ),
    );

    Widget _mobile = Obx(() => storyController.stories.length == 0
        ? BlueBackground(
            addHeader: true,
          )
        : pageView);

    Widget _webTabletAndDesktop(padding) {
      storyController.setIsWeb();
      Widget _story(story) {
        return Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Story(
              story: story,
              isFirstStory: false,
            ),
            height: webStoryHeight[story.type]! + 20);
      }

      // bool _isColumnStory(index) {
      //   return webColumnStories
      //       .contains(storyController.getWebStories[index].type);
      // }

      Widget _itemBuilder(BuildContext context, int index) {
        if (storyController.webStories.length <= index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
                padding: padding,
                child: ShimmeryPlaceHolder(
                  radius: 0,
                )),
            height: webStoryHeight[StoryType.FeaturedArticle]! +
                20, // TODO: how do we know what the height is when we do not know what story will load? ********
          );
        }
        return Padding(
            padding: padding, child: _story(storyController.webStories[index]));
      }

      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.productsBgWhite,
        appBar: GlorifiAppBar(
          title: "",
        ),
        body: Column(
          children: [
            Padding(padding: padding, child: Greeting()),
            Expanded(
                child: Obx(() => NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (notification.metrics.atEdge) {
                          if (notification.metrics.pixels == 0) {
                            // Log.info('At top');
                          } else {
                            // Log.info('At bottom');
                            if (!storyController.fetchedLastStory) {
                              // storyController.preLoadStories();
                              // not tested yet
                              // if (storyController.preLoad ==
                              //     storyController.webStories.length) {
                              //   storyController.preLoad =
                              //       storyController.preLoad + 10;
                              // storyController.preLoadComplete();
                            }
                          }
                        }
                        return true;
                      },
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: ListView.builder(
                            // cacheExtent: 9999,
                            shrinkWrap: true,
                            itemBuilder: _itemBuilder,
                            itemCount: storyController.webStories.length < 3
                                ? 3
                                : storyController.webStories.length),
                      ),
                    )))
          ],
        ),
      );

      // AdaptiveGrid is freezing the screen so we are using a ListView
      // child: Obx(() => AdaptiveGrid(children: [
      //       ...List<AdaptiveGridItem>.generate(
      //           storyController.getWebStories.length < 3
      //               ? 3
      //               : storyController.getWebStories.length, (index) {
      //         if (storyController.getWebStories.length <= index) {
      //           return AdaptiveGridItem(
      //               desktop: 100,
      //               child: Container(
      //                 child: ShimmeryPlaceHolder(
      //                   radius: 0,
      //                 ),
      //                 height: webStoryHeight[StoryType.OneArticle],
      //               ));
      //         }

      //         return AdaptiveGridItem(
      //             desktop: _isColumnStory(index) ? 50 : 100,
      //             child: _story(storyController.getWebStories[index]));
      //       })
      //     ]))));
    }

    Widget _desktop() {
      return _webTabletAndDesktop(EdgeInsets.symmetric(
          horizontal: (1.sw - 1024.0) / 2, vertical: 20.h));
    }

    Widget _tablet() {
      return _webTabletAndDesktop(
          EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 20.h));
    }

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.isNativeMobile) {
        return _mobile;
      } else if (sizingInfo.isWebMobile) {
        return _mobile;
      } else if (sizingInfo.isDesktop) {
        return _desktop();
      } else if (sizingInfo.isTablet) {
        return _tablet();
      } else {
        return SizedBox.shrink();
      }
    });
  }
}

class _CustomPageViewScrollPhysics extends ScrollPhysics {
  const _CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  _CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 1,
      );
}
