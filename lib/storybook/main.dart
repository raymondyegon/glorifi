import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/debt_visuals.dart';
import 'package:glorifi/src/feature/success/success_screen.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/cards/compare_with_others.dart';
import 'package:glorifi/src/widgets/cards/info_card.dart';
import 'package:glorifi/src/widgets/charts/bar_chart.dart';
import 'package:glorifi/src/widgets/charts/credit_score_chart.dart';
import 'package:glorifi/src/widgets/charts/horizontal_bar_chart.dart';
import 'package:glorifi/src/widgets/charts/line_chart/line_chart.dart';
import 'package:glorifi/src/widgets/charts/pie_chart.dart';
import 'package:glorifi/src/widgets/charts/total_debt_chart.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:glorifi/storybook/widgets/color_palette.dart';
import 'package:glorifi/storybook/widgets/personal_snapshot.dart';
import 'package:glorifi/storybook/widgets/type_treatments.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class MainStorybook extends StatelessWidget {
  static const routeName = '/stories';

  const MainStorybook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveUtilInit(
      builder: () {
        return Storybook(
          storyWrapperBuilder: (context, story, child) => Stack(
            children: [
              Container(
                width: double.infinity,
                padding: story.padding,
                child: Center(child: child),
              ),
            ],
          ),
          children: [
            Story.simple(
              section: 'Styleguide',
              name: 'Color Palette',
              child: const Scaffold(
                body: ColorPalette(),
              ),
            ),
            Story.simple(
              section: 'Styleguide',
              name: 'Type Treatments',
              child: const Scaffold(
                body: TypeTreatments(),
              ), //,
            ),
            Story.simple(
              section: 'Personal Snapshot',
              name: 'Widget',
              child: const Scaffold(
                backgroundColor: Colors.black,
                body: PersonalSnapshot(),
              ), //,
            ),
            Story.simple(
              section: 'Charts',
              name: 'Bar Chart',
              child: Scaffold(
                body: SizedBox(
                  width: 300,
                  height: 300,
                  child: BarChart(
                    data: [
                      BarChartTypeInfo('Jan', 60),
                      BarChartTypeInfo('Feb', 40),
                      BarChartTypeInfo('Mar', 80),
                      BarChartTypeInfo('Apr', 70),
                      BarChartTypeInfo('Jun', 90),
                    ],
                    selectedIndex: 4,
                  ),
                ),
              ), //,
            ),
            Story.simple(
              section: 'Charts',
              name: 'Pie Chart',
              child: Scaffold(
                body: SizedBox(
                  width: 500,
                  height: 500,
                  child: PieChart(
                    data: [
                      PieChartTypeInfo('Val1', 20),
                      PieChartTypeInfo('Val2', 20),
                    ],
                  ),
                ),
              ), //,
            ),
            Story(
              section: 'Charts',
              name: 'Line Chart',
              builder: (context, k) => Scaffold(
                body: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: LineChartWidget(
                    data: [
                      TimeLineChartTypeInfo(
                        DateTime(2017, 9, 25),
                        k.slider(
                          label: 'Value1',
                          initial: 6,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 9, 26),
                        k.slider(
                          label: 'Value2',
                          initial: 8,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 9, 27),
                        k.slider(
                          label: 'Value3',
                          initial: 6,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 9, 28),
                        k.slider(
                          label: 'Value4',
                          initial: 9,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 9, 29),
                        k.slider(
                          label: 'Value5',
                          initial: 11,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 9, 30),
                        k.slider(
                          label: 'Value6',
                          initial: 15,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 10, 01),
                        k.slider(
                          label: 'Value7',
                          initial: 25,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 10, 02),
                        k.slider(
                          label: 'Value8',
                          initial: 33,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 10, 03),
                        k.slider(
                          label: 'Value9',
                          initial: 27,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 10, 04),
                        k.slider(
                          label: 'Value10',
                          initial: 31,
                          min: 0,
                          max: 100,
                        ),
                      ),
                      TimeLineChartTypeInfo(
                        DateTime(2017, 10, 05),
                        k.slider(
                          label: 'Value11',
                          initial: 23,
                          min: 0,
                          max: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ), //,
            ),
            Story(
              section: 'Charts',
              name: 'Horizontal Bar Chart',
              builder: (context, k) => Scaffold(
                body: SizedBox(
                  width: double.maxFinite,
                  height: 400,
                  child: HorizontalBarChart(
                    data: [
                      HorizontalBarChartTypeInfo(
                        k.text(
                          label: 'Year1',
                          initial: '2016',
                        ),
                        k
                            .sliderInt(
                              label: 'Value1',
                              initial: 0,
                            )
                            .toDouble(),
                      ),
                      HorizontalBarChartTypeInfo(
                        k.text(
                          label: 'Year2',
                          initial: '2017',
                        ),
                        k
                            .sliderInt(
                              label: 'Value2',
                              initial: 0,
                            )
                            .toDouble(),
                      ),
                    ],
                  ),
                ),
              ), //,
            ),
            Story(
              section: 'Charts',
              name: 'Credit score chart',
              builder: (context, k) => Scaffold(
                body: SizedBox(
                  width: double.maxFinite,
                  child: CreditScoreChart(
                    creditScore: k
                        .slider(
                          label: 'Value2',
                          initial: 400,
                          min: 300,
                          max: 850,
                        )
                        .toInt(),
                    label: 'Good',
                  ),
                ),
              ), //,
            ),
            Story(
              section: 'Charts',
              name: 'Total debt chart',
              builder: (context, k) => Scaffold(
                body: SizedBox(
                  width: double.maxFinite,
                  child: TotalDebtChart(
                    creditDebt: 1000,
                    installmentDebt: 314000,
                  ),
                ),
              ), //,
            ),
            Story(
              section: 'Cards',
              name: 'Info Card',
              builder: (context, k) => Scaffold(
                body: InfoCard(
                  title1: k.text(
                    label: 'Title1',
                    initial: 'Loan Debt',
                  ),
                  text1: k.text(
                    label: 'Text1',
                    // ignore: use_raw_strings
                    initial: '\$7,000',
                  ),
                  title2: k.text(
                    label: 'Title2',
                    initial: 'Long term loan',
                  ),
                  text2: k.text(
                    label: 'Text2',
                    // ignore: use_raw_strings
                    initial: '\$600,000',
                  ),
                  paragraph: k.text(
                    label: 'Paragraph',
                    initial:
                        'Your debt-to-income ratio is all your monthly debt payments divided by your gross monthly income.',
                  ),
                  data: const Spacer(),
                ),
              ), //,
            ),
            Story(
              section: 'Cards',
              name: 'Compare with Others',
              builder: (context, k) => Scaffold(
                body: CompareWithOthers(
                  text1: k.text(
                    label: 'Text',
                    initial: '61',
                  ),
                  paragraph: k.text(
                    label: 'Paragraph',
                    initial:
                        // ignore: use_raw_strings
                        "Did you know that 61 percent of Americans don’t have enough savings to cover a \$1,000 emergency?",
                  ),
                  onPressed: () {},
                ),
              ), //,
            ),
            Story(
              name: 'Button',
              section: 'Buttons',
              builder: (context, k) => ElevatedButton(
                onPressed:
                    k.boolean(label: 'Enabled', initial: true) ? () {} : null,
                child: Text(k.text(label: 'Text', initial: 'Continue')),
              ),
            ),
            Story(
              name: 'Glorifi Spinner',
              section: 'Loading',
              builder: (context, k) => Scaffold(
                body: Center(
                  child: GlorifiSpinner(),
                ),
              ),
            ),
            Story(
              name: 'Success Screens',
              section: 'Screens',
              builder: (context, k) => Scaffold(
                body: Center(
                  child: SuccessScreen(
                    appBarTitle: k.text(
                      label: 'appBarTitle',
                      initial: 'Link Bank Account',
                    ),
                    title: k.text(
                      label: 'title',
                      initial: 'Your bank account was added!',
                    ),
                    text: k.text(
                      label: 'text',
                      initial:
                          'To see your Full Net Worth Picture link your Liabilities by requesting your Credit Report. It doesn’t affect your credit score.',
                    ),
                    buttonText: k.text(
                      label: 'buttonText',
                      initial: 'Request Credit Score',
                    ),
                    onPressedButton: () => {},
                    extraButtonText: k.text(
                      label: 'extraButtonText',
                      initial: 'Skip for now',
                    ),
                  ),
                ),
              ),
            ),
            Story(
                name: 'Total Debt Visuals',
                section: 'Charts',
                builder: (context, k) => SingleChildScrollView(
                  child: AdaptiveBuilder(builder: (context, sizingInfo) {
                    return DebtVisuals(
                        totalDebt: 100,
                        installmentDebt: 70,
                        creditDebt: 30,
                        sizingInfo: sizingInfo,
                      );
                  })
                ))
          ],
        );
      }
    );
  }
}
