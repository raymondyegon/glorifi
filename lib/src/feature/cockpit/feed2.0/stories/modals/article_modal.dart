import 'package:cached_network_image/cached_network_image.dart';
import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/base_modal.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/modals/close_app_bar.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/close_modal_button.dart';

import '../../../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

class ArticleModal extends StatefulWidget {
  final ArticleStoryModel data;

  const ArticleModal({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ArticleModal> createState() => _ArticleModal();
}

class _ArticleModal extends State<ArticleModal> {
  var richContent;
  var author;

  @override
  void initState() {
    super.initState();
    getContent();
  }

  getContent() async {
    var controller = Get.find<StoryController>();
    var content = await controller.getInternalArticle(widget.data.contentId);
    if (content != null && content["fields"]["articleBody"] != null) {
      if (content["fields"]["articleBody"] != null) {
        setState(() {
          richContent = content["fields"]["articleBody"];
          author = content["fields"]["author"];
        });
      }
      if (content["fields"]["author"] != null) {
        setState(() {
          author = content["fields"]["author"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget cachedNetworkImage = Stack(children: [
      CachedNetworkImage(
        imageUrl: widget.data.imageUrl,
        width: Get.width,
        height: 328.h,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => SvgPicture.asset(
          "assets/images/placeholder.svg",
          fit: BoxFit.fitWidth,
        ),
      ),
    ]);

    Widget dateText = Text(
      widget.data.formattedPublishDate,
      style: captionSemiBold14Primary(
        color: GlorifiColors.creditBgGrey,
      ),
    );

    Widget headLineText = Text(
      widget.data.headline,
      style: headlineRegular21Secondary(
        color: GlorifiColors.cornflowerBlue,
      ).copyWith(height: 32 / 21),
    );

    Widget sourceText = Text(
      widget.data.source.toUpperCase(),
      style: smallSemiBold16Primary(
        color: GlorifiColors.creditBgGrey,
      ),
    );

    Widget authorStack = author != null
        ? Text(
            "By " + author,
            style:
                smallSemiBold16Primary(color: GlorifiColors.blueMidnightBlue),
          )
        : SizedBox.shrink();

    Widget _content() {
      return richContent == null
          ? SizedBox.shrink()
          : ContentfulRichText(richContent).documentToWidgetTree;
    }

    return Container(
      color:GlorifiColors.productsBgWhite,
      padding: EdgeInsets.only(top: 23.h),
      child: AdaptiveBuilder(builder: (context, sizingInfo) {
        return AdaptiveScaffold(
            appBar:GlorifiAppBar(
              title: "GloriFi",
              disableLeading: true,
              trailing: Trailing(
                onTap: () {
                  Get.back();
                },
                text: "Close",
                textStyle: captionSemiBold14Primary(
                  color: GlorifiColors.darkOrange,
                ),
              ),
            ),
            backgroundColor: GlorifiColors.productsBgWhite,
            body: BaseModal(
                child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizingInfo.isDesktop ? 200.w : 0.w,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1024),
                child: AdaptiveGrid(
                  children: [
                    AdaptiveGridItem(
                      desktop: 66,
                      nativeMobile: 100,
                      tablet: 100,
                      webMobile: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (!sizingInfo.isNativeMobile)
                              ? cachedNetworkImage.paddingOnly(
                                  left: 32.w,
                                  top: 142.h,
                                  right: 32.w,
                                  bottom: 64.h)
                              : cachedNetworkImage,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 48.h,
                              horizontal: 32.w,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dateText,
                                  SizedBox(height: 16.h),
                                  headLineText,
                                  SizedBox(height: 16.h),
                                  Row(
                                    children: [
                                      sourceText,
                                      if (widget.data.author != null) Spacer(),
                                      if (widget.data.author != null) authorStack,
                                    ],
                                  ),
                                  SizedBox(height: 45.h),
                                  _content(),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
      }),
    );
  }
}
