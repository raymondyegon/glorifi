import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/article_modal.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/video_modal.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_tappable.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';

class BaseSecondaryContentStory extends GetView<StoryController> {
  final story;
  final StoryContentType contentType;
  const BaseSecondaryContentStory(
      {Key? key, required this.story, required this.contentType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _image(url, width, height) {
      return CachedNetworkImage(
        imageUrl: url,
        width: width,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Center(
            child: SizedBox(
                width: width, height: height, child: ShimmeryPlaceHolder())),
        errorWidget: (context, url, error) => SvgPicture.asset(
          "assets/images/placeholder.svg",
          fit: BoxFit.fitWidth,
        ),
      );
    }

    Widget _details({data, isFeatured: true}) {
      Widget _source = Text(
        data.source,
        style: TextStyle(color: Colors.white),
      );

      Widget _duration = Text(
          "2 min ${contentType == StoryContentType.Video ? "watch" : "read"}",
          style: TextStyle(color: Colors.white));

      Widget _icon = contentType == StoryContentType.Video
          ? Image.asset('assets/images/tv.png')
          : Image.asset('assets/images/book.png');

      Widget _featuredDetails = Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white, width: 0.5))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _source,
            SizedBox(
              width: 10,
            ),
            Row(children: [
              _icon,
              SizedBox(
                width: 10.w,
              ),
              _duration,
            ])
          ]));

      Widget _secondaryDetails =
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _source,
        SizedBox(
          height: 10.h,
        ),
        Row(children: [
          _icon,
          SizedBox(
            width: 10.w,
          ),
          _duration,
        ])
      ]);

      return isFeatured ? _featuredDetails : _secondaryDetails;
    }

    Widget _content(data, width, height, {isFeatured: true}) {
      return BaseTapStory(
          onTap: () {
            if (contentType == StoryContentType.Video) {
              // controller.videoController
              //     .changeVideo(fromNetworkUrl: data.videoUrl);
              controller.playYoutubeVideo(data.videoUrl);
            }
          },
          modal: contentType == StoryContentType.Video
              ? VideoModal()
              : ArticleModal(data: data),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: _image(data.imageUrl, width, height)),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: width,
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Text(data.headline,
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'univers'))),
              _details(data: data, isFeatured: isFeatured)
            ],
          ));
    }

    return BaseStory(
        child: Container(
            color: GlorifiColors.midnightBlue,
            child: Column(children: [
              Padding(
                  padding:
                      EdgeInsets.only(top: 50.h, left: .05.sw, right: .05.sw),
                  child: _content(story.hero, 1.sw, 200.h, isFeatured: true)),
              SizedBox(
                height: 20.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _content(story.secondary[0], .45.sw, .45.sw, isFeatured: false),
                _content(story.secondary[1], .45.sw, .45.sw, isFeatured: false)
              ])
            ])));
  } //
}
