import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_models.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/base_insight.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class DoubleBoxInsight extends StatelessWidget {
  final int index;
  final InsightsModel insight;
  final String title;
  final String body;
  final String date;

  const DoubleBoxInsight(
      {Key? key,
      required int this.index,
      required InsightsModel this.insight,
      required this.title,
      required this.body,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
// Box One Labels and Values
    int lableOneIndex = insight.teaserBlocks!
        .indexWhere((element) => element.blockId == 'box-label1');
    int valueOneIndex = insight.teaserBlocks!
        .indexWhere((element) => element.blockId == 'box-value1');
    String? labelOneText = insight.teaserBlocks![lableOneIndex].text;
    String? valueOneText = insight.teaserBlocks![valueOneIndex].text;

    // Box Two Labels and Values
    int lableTwoIndex = insight.teaserBlocks!
        .indexWhere((element) => element.blockId == 'box-label2');
    int valueTwoIndex = insight.teaserBlocks!
        .indexWhere((element) => element.blockId == 'box-value2');
    String? labelTwoText = insight.teaserBlocks![lableTwoIndex].text;
    String? valueTwoText = insight.teaserBlocks![valueTwoIndex].text;

    return BaseInsight(
      insight: insight,
      title: title,
      body: body,
      date: date,
      height: 484.h,
      child: Container(
          height: 100,
          padding: const EdgeInsets.only(top: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      valueOneText!,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 21,
                        fontFamily: "OpenSans",
                        color: Color(0xFF1F3B73),
                      ),
                    ),
                  ),
                  Text(
                    labelOneText!,
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "OpenSans",
                      color: Color(0xFF212C37),
                    ),
                  )
                ],
              ),
              //Divider Line
              Container(
                height: 60,
                width: 3,
                color: Colors.grey[300],
              ),
              Column(
                // ignore: use_raw_strings
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      valueTwoText!,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 21,
                        fontFamily: "OpenSans",
                        color: Color(0xFF1F3B73),
                      ),
                    ),
                  ),
                  Text(
                    labelTwoText!,
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "OpenSans",
                      color: Color(0xFF212C37),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class DoubleBoxData {
  DoubleBoxData(
      this.boxLabelOne, this.boxValueOne, this.boxLabelTwo, this.boxValueTwo);

  final String boxLabelOne;
  final String boxValueOne;
  final String boxLabelTwo;
  final String boxValueTwo;
}
