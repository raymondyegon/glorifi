import 'package:flutter/material.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'widgets/enable_to_see_data_widget.dart';

class EnableToSeeDataScreen extends StatelessWidget {
  const EnableToSeeDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: 'Personal Snapshot',
        trailing: Trailing(
          onTap: () {},
          text: "Edit",
        ),
      ),
      body: EnableToSeeDataWidget(),
    );
  }
}
