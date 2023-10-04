import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/statements/controller/cc_statements_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/statements/models/statement_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/charts/glorifi_barchart/glorifi_bar_chart.dart';
import 'package:glorifi/theme.dart';

class CCStatementsScreen extends GetView<CCStatementsController> {
  const CCStatementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GlorifiAppBar(
          title: 'Statements',
        ),
        backgroundColor: GlorifiColors.culturedWhite,
        body: ListView(
          children: [
            getBarChartAndInfo(),
            SizedBox(
              height: 50,
            ),
            ListView.separated(
              shrinkWrap: true,
              primary: false, //disable list view scroll
              itemCount: controller.statementsMap.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCollapsableList(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 16.h,
                );
              },
            )
          ],
        ));
  }

  Row statementsInfo({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: captionRegular14Primary(color: GlorifiColors.darkBlue)),
        Text(
          value,
          style: captionSemiBold14Primary(color: GlorifiColors.darkGrey80),
        ),
      ],
    );
  }

  Widget getBarChartAndInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          Container(
            height: 230.h,
            //TODO: Replace with API Data
            child: GloriFiBarChart(data: controller.barchartData, barGap: 16.w),
          ),
          SizedBox(
            height: 32,
          ),
          statementsInfo(
              title: controller.lastStatementTitle,
              value: controller.lastStatementValue),
          SizedBox(
            height: 20,
          ),
          statementsInfo(
              title: 'Spending since last statement',
              value: controller.spendingSinceLastStatement),
          SizedBox(
            height: 20,
          ),
          statementsInfo(
              title: 'Next Statement', value: controller.nextStatementDate),
        ],
      ),
    );
  }

  Widget _buildCollapsableList(int index) {
    return Theme(
      data: CustomTheme.basicTheme.copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Column(
        children: [
          ExpansionTile(
            iconColor: GlorifiColors.darkGrey,
            collapsedIconColor: GlorifiColors.darkGrey,
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            title: _getStatementTitle(controller.statementsMap[index]['year']),
            children: _getStatements(controller.statementsMap[index]['statements']),
          ),
        ],
      ),
    );
  }

  List<Widget> _getStatements(List<StatementModel> statements) {
    List<Widget>widgets = [];
    for(StatementModel sm in statements){
      widgets.add(Container(height: 1, width: double.infinity, color: Colors.grey[200]));
      widgets.add(Padding(
        padding: EdgeInsets.fromLTRB(24.h, 16.h, 0, 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sm.month,
              style: captionBold14Primary(color: GlorifiColors.darkBlue),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Ending on ${sm.formattedEndDate}',
                  style: captionSemiBold14Primary(
                      color: GlorifiColors.creditBgGrey),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
              ],
            )
          ],
        ),
      ));
    }
    return widgets;
  }

  _getStatementTitle(String year) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "$year Statements",
        style: bodyBold18Primary(color: GlorifiColors.midnightBlueColor),
      ),
    );
  }
}
