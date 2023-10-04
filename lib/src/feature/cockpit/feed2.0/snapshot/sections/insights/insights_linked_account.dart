import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_shimmer.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_story/insights_story_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_empty.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_models.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/double_box_insight.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/horizontal_bar/horizontal_bar_insight.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/image_insight.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/pie_chart/pie_chart_insight.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/pin_chart_insight.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/vertical_bar_insight.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class InsightsLinkedAccount extends GetView<InsightsController> {
  InsightsLinkedAccount({Key? key, required this.sizingInfo}) : super(key: key);

  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    Get.put(InsightsStoryController());

    List<Widget> columnsArray = <Widget>[];
    List<Widget> rowsArray = <Widget>[];

    // ^^ Within Insight Story .dart it finds this controller ^^
    return controller.obx(
      (state) {
        var length = controller.inboxInsightsModelList.length;

        for (var i = 0; i < length; i++) {
          var isPar = ((i + 1) % 2) == 0;

          rowsArray.add(
            _cardContainer(
              isPar,
              child: _cardForInsight(
                controller.inboxInsightsModelList[i],
                i,
                controller.teaserTitles[i],
                controller.teaserBodies[i],
                controller.teaserDates[i],
              ),
            ),
          );

          if (sizingInfo.isWebMobile || sizingInfo.isNativeMobile) {
            columnsArray.add(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _cardForInsight(
                  controller.inboxInsightsModelList[i],
                  i,
                  controller.teaserTitles[i],
                  controller.teaserBodies[i],
                  controller.teaserDates[i],
                ),
              ),
            );
          } else if (isPar) {
            columnsArray.add(Row(children: rowsArray));
            rowsArray = <Widget>[];
          } else if (!isPar && length == i + 1) {
            rowsArray.add(_cardContainer(isPar));
            columnsArray.add(Row(children: rowsArray));
          }
        }

        return Container(
          color: GlorifiColors.productsBgWhite,
          height: Get.height,
          width: double.maxFinite,
          child: ListView(
            padding: EdgeInsets.only(
              bottom: 100.h,
            ),
            shrinkWrap: true,
            children: columnsArray,
          ),
        );
      },
      onLoading: InsightsShimmer(),
      onEmpty: PersoneticsEmpty(),
      onError: (error) => Text("Check Back Soon"),
    );
  }
}

Widget _cardContainer(bool isPar, {Widget? child}) {
  return Expanded(
    flex: 5,
    child: Container(
      margin: EdgeInsets.only(
        right: isPar ? 0 : 10,
        left: isPar ? 10 : 0,
        top: 10,
        bottom: 10,
      ),
      child: child,
    ),
  );
}

Widget _cardForInsight(
    InsightsModel insight, int index, String title, String body, String date) {
  switch (insight.teaserTemplate) {
    case "horizontalBar":
      return HorizontalBarInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "doubleBox":
      return DoubleBoxInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "verticalBar":
      return VerticalBarInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "image":
      return ImageInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "pinChart":
      return PinChartInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "pie":
      return PieChartInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "lineChart":
      return ImageInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "imageAndText":
      return ImageInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "entitySelector":
      return ImageInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    case "doubleBoxWithIcons":
      return DoubleBoxInsight(
        index: index,
        insight: insight,
        title: title,
        body: body,
        date: date,
      );
    default:
      return SizedBox.shrink();
    //return DefaultTeaser(index: index);
  }
}
