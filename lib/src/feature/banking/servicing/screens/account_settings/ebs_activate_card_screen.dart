import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/ebs_container.dart';

class EBSActivateCard extends StatelessWidget {
  const EBSActivateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EBSContainer(
      title: 'Activate Card',
      children: [Text('activate goes here')],
      showSettings: false,
    );
  }
}
