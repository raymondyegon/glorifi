import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/dropdown_widgets/snapshot_dropdown.dart';

class SnapshotDropdownSection extends StatelessWidget {
  const SnapshotDropdownSection({
    Key? key,
    required this.title,
    required this.dropdowns,
  }) : super(key: key);

  final String title;
  final List<SnapshotDropdown> dropdowns;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Univers',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(
            color: Color(0xFFD4DEF4),
          ),
          Column(
            children: dropdowns,
          )
        ],
      ),
    );
  }
}
