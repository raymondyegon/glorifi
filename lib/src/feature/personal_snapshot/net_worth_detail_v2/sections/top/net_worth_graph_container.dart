import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/sections/top/net_worth_graph.dart';
import 'package:glorifi/src/widgets/charts/chart_data_models.dart';
import 'package:intl/intl.dart';

class NetWorthGraphContainer extends StatelessWidget {
  final List<GraphData> data;

  NetWorthGraphContainer(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          NetWorthGraph(data: data),
          SizedBox(height: 20),
          Text(
            'As of ${DateFormat.MMMd().format(DateTime.now())} (Updated Daily)',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
