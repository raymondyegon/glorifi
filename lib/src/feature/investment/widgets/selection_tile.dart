import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';

class SelectionTile extends StatelessWidget {
  const SelectionTile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: titleTextStyle,
        ),
      ),
    );
  }
}
