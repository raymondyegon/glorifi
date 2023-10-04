import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/sections/top/retirement_graph_label.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/sections/top/retirement_graph.dart';
import 'package:glorifi/src/widgets/charts/chart_data_models.dart';

class RetirementGraphContainer extends StatelessWidget {
  const RetirementGraphContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataJSON = {
      "2018-06-07": 650.0,
      "2019-06-07": 1000.0,
      "2019-09-07": 950.0,
      "2020-06-05": 1350.0,
      "2020-12-05": 1380.0,
      "2021-06-05": 1400.0,
      "2022-05-09": 2100.42
    };

    List<GraphData> data = _getXAxisDates(dataJSON);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          RetirementGraph(data: data),
          RetirementGraphLabel(),
          SizedBox(height: 20),
          Text(
            'As of March 10 (pull everyday)',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

List<GraphData> _getXAxisDates(cohData) {
  List<GraphData> arr = [];
  cohData.forEach((key, value) {
    var splitData = key.split('-');
    int year = int.parse(splitData[0]);
    int month = int.parse(splitData[1]);
    int day = int.parse(splitData[2]);

    var datetime = DateTime(year, month, day);
    arr.add(GraphData(datetime, value));
  });
  arr.sort((a, b) => a.x.compareTo(b.x));
  return arr;
}
