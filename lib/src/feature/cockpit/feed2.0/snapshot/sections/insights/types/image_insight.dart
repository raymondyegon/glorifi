import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_models.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/base_insight.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ImageInsight extends StatelessWidget {
  final int index;
  final InsightsModel insight;
  final String title;
  final String body;
  final String date;
  const ImageInsight(
      {Key? key,
      required int this.index,
      required InsightsModel this.insight,
      required this.title,
      required this.body,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInsight(
      insight: insight,
      title: title,
      body: body,
      date: date,
      height: 484.h,
      child: Expanded(
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
