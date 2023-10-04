// ignore_for_file: use_raw_strings

import 'package:flutter/material.dart';
import 'package:glorifi/src/widgets/cards/compare_with_others.dart';
import 'package:glorifi/src/widgets/cards/info_card.dart';
import 'package:glorifi/src/widgets/charts/horizontal_bar_chart.dart';
import 'package:glorifi/src/widgets/charts/line_chart/line_chart.dart';

class PersonalSnapshot extends StatelessWidget {
  const PersonalSnapshot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: width,
      height: height,
      child: ListView(
        children: [
          CompareWithOthers(
            text1: '61',
            paragraph:
                'Did you know that 61 percent of Americans don’t have enough savings to cover a \$1,000 emergency?',
            onPressed: () {},
          ),
          const SizedBox(height: 28),
          InfoCard(
            title1: 'Net Worth',
            text1: '\$0',
            data: SizedBox(
              width: 300,
              height: 100,
              child: LineChartWidget(
                data: [
                  TimeLineChartTypeInfo(DateTime(2017, 9, 25), 6),
                  TimeLineChartTypeInfo(DateTime(2017, 9, 26), 8),
                  TimeLineChartTypeInfo(DateTime(2017, 9, 27), 6),
                  TimeLineChartTypeInfo(DateTime(2017, 9, 28), 9),
                  TimeLineChartTypeInfo(DateTime(2017, 9, 29), 11),
                  TimeLineChartTypeInfo(DateTime(2017, 9, 30), 15),
                  TimeLineChartTypeInfo(DateTime(2017, 10, 01), 25),
                  TimeLineChartTypeInfo(DateTime(2017, 10, 02), 33),
                  TimeLineChartTypeInfo(DateTime(2017, 10, 03), 27),
                  TimeLineChartTypeInfo(DateTime(2017, 10, 04), 31),
                  TimeLineChartTypeInfo(DateTime(2017, 10, 05), 23),
                ],
              ),
            ),
          ),
          InfoCard(
            title1: 'Debt/Income Ratio',
            text1: '28%',
            paragraph:
                'Your debt-to-income ratio is all your monthly debt payments divided by your gross monthly income.',
            data: SizedBox(
              width: width,
              height: 100,
              child: HorizontalBarChart(
                data: [
                  HorizontalBarChartTypeInfo('2016', 100),
                  HorizontalBarChartTypeInfo('2017', 45),
                ],
              ),
            ),
            onPressed: () {},
          ),
          const InfoCard(
            title1: 'Cash on Hand',
            text1: '\$43,000',
            data: SizedBox(height: 100),
          ),
          const InfoCard(
            title1: 'Home Value',
            text1: '\$0',
            data: SizedBox(height: 100),
          ),
          const InfoCard(
            title1: 'Loan Debt',
            text1: '\$7,000',
            title2: 'Long term loan',
            text2: '\$600,000',
            paragraph:
                'Your debt-to-income ratio is all your monthly debt payments divided by your gross monthly income. ',
            data: SizedBox(height: 100),
          ),
          const InfoCard(
            title1: 'Credit Card Debt',
            text1: '\$5,000',
            paragraph:
                'Your debt-to-income ratio is all your monthly debt payments divided by your gross monthly income. ',
            data: SizedBox(height: 100),
          ),
          const InfoCard(
            title1: 'Credit Score',
            text1: '0',
            data: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}
