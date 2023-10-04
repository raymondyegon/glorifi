import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BaseModal extends StatelessWidget {
  final Widget child;

  const BaseModal({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 1.sh,
        child: SingleChildScrollView(
          child: child,
        ));
  }
}
