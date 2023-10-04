import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncludeInSnapshotSelection extends StatelessWidget {
  const IncludeInSnapshotSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Include in Snapshot'),
            CupertinoSwitch(
              value: true,
              // activeColor: Color(0xFF162A52),
              onChanged: (bool value) {},
            ),
          ],
        ),
      ),
    );
  }
}
