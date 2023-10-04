import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_utils.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/personetics_models.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BaseInsight extends StatelessWidget {
  final Widget child;
  final double height;
  final String title;
  final String body;
  final String date;
  final InsightsModel insight;

  const BaseInsight(
      {Key? key,
      required this.child,
      required this.height,
      required this.insight,
      required this.title,
      required this.body,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var parameterData = {
      "insightId": insight.id!,
      "instanceId": insight.insightId!,
      "title": title,
      'insightData': insight.toString()
    };
    return Align(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(, 0),
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 55,
          //   ),
          // ],
          color: Colors.white,
        ),
        margin: EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20, //ToDo: first card padding should be remove
        ),
        width: double.infinity,
        height: height,
        child: Stack(
          children: [
            Positioned(
              // height: height - 80.h,
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 8),
                        child: Text(
                          date,
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212C37),
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Color(0xFF1F3B73),
                        fontWeight: FontWeight.w700,
                        fontSize: 21.sp,
                        fontFamily: 'univers',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      body,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Color(0xFF212C37),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  child,
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                height: 72.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        deleteInsight(context, insight.id!);
                      },
                      child: SvgPicture.asset(
                        'assets/images/Circle Minus.svg',
                        height: 24,
                        width: 24,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.insightsStory,
                            parameters: parameterData);
                      },
                      child: Row(
                        children: [
                          Text(
                            'Full Story',
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF212C37),
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
