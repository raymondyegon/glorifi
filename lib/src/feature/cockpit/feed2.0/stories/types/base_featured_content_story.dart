import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/today_feed.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/play_button.dart';
import 'package:glorifi/src/widgets/loading/blue_background.dart';

class BaseFeaturedContentStory extends StatelessWidget {
  final story;
  final bool isFirstStory;
  final StoryContentType contentType;
  final bool playButton;
  final String? backgroundImageURL;
  final Widget? modal;
  final Function? onTap;

  const BaseFeaturedContentStory(
      {Key? key,
      required this.story,
      this.isFirstStory: false,
      this.playButton = false,
      required this.contentType,
      this.modal = null,
      this.onTap,
      this.backgroundImageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _info = Row(
      children: [
        SvgPicture.asset(
          contentType == StoryContentType.Video ? 'assets/images/tv.svg' : 'assets/images/book.svg',
          color: Colors.white.withOpacity(0.6),
        ),
        SizedBox(
          width: 7,
        ),
        Text("${story.duration} min ${contentType == StoryContentType.Video ? "watch" : "read"}",
            style: TextStyle(color: GlorifiColors.superLightGrey)),
      ],
    );

    Widget _headline({maxLines: 5}) {
      return Text(story.headline,
          maxLines: 5,
          style: TextStyle(
            color: GlorifiColors.superLightGrey,
            fontFamily: 'univers',
            overflow: TextOverflow.ellipsis,
            height: 1.5,
            fontSize: 20,
          ));
    }

    BoxDecoration _lineDecoration = BoxDecoration(
        border: Border(
            bottom: BorderSide(
      color: Colors.white.withOpacity(0.6),
      width: 0.5,
    )));

    Widget _source = Text(
      story.source,
      maxLines: 1,
      style: TextStyle(color: GlorifiColors.superLightGrey),
    );

    Widget _mobile = Container(
        padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 30.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (contentType == StoryContentType.Article)
                Text(
                  story.formattedPublishDate,
                  style: TextStyle(color: Colors.white),
                ),
              Container(
                  width: 1.sw,
                  padding: EdgeInsets.only(bottom: 30),
                  decoration: _lineDecoration,
                  child: _headline(maxLines: 10)),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Container(width: 200, child: _source),
                    _info,
                  ])),
            ]));

    Widget _contentInfo(width) {
      return Container(
          padding: EdgeInsets.all(20),
          color: GlorifiColors.midnightBlueColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 10.h),
                    decoration: _lineDecoration,
                    child: _headline()),
                SizedBox(
                  height: 20.h,
                ),
                Row(children: [Container(width: width * 0.35, child: _source), _info]),
              ]));
    }

    Widget _image({imageUrl, fit, height, width}) {
      return CachedNetworkImage(
        fit: fit,
        imageUrl: imageUrl + "?w=300",
        placeholder: (context, url) => BlueBackground(),
        errorWidget: (context, url, error) => BlueBackground(),
        height: height,
        width: width,
      );
    }

    Widget _webView(child, width, ratio_1, ratio_2) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(alignment: Alignment.center, children: [
              _image(
                fit: BoxFit.cover,
                height: webStoryHeight[StoryType.FeaturedVideo]!,
                width: width * ratio_1,
                imageUrl: backgroundImageURL,
              ),
              if (playButton) PlayButton(height: 100.h),
            ]),
            Container(
                width: width * ratio_2,
                height: webStoryHeight[StoryType.FeaturedVideo],
                child: child),
          ]);
    }

    
      return AdaptiveBuilder(builder: (context, sizingInfo) {
      Widget s = SizedBox.shrink();
      String? image;
      
        if (sizingInfo.isNativeMobile) {
        s = _mobile;
        image = backgroundImageURL;
        } else if (sizingInfo.isWebMobile) {
        s = _mobile;
        image = backgroundImageURL;
        } else if (sizingInfo.isDesktop) {
        s = _webView(_contentInfo(0.6 * 1024), 1024.0, .4, .6);
        } else if (sizingInfo.isTablet) {
        s = _webView(_contentInfo(0.55.sw), 1.sw, .35, .55);
      }
      return BaseStory(
        child: s,
        isFirstStory: isFirstStory,
        modal: modal,
        playButton: sizingInfo.isNativeMobile || sizingInfo.isWebMobile ? playButton : false,
        backgroundImageURL: image,
        onTap: onTap,
      );
    });
    
  }
}
