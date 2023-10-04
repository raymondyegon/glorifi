import 'package:flutter/material.dart';

class ProductsScreenContainer extends StatelessWidget {
  const ProductsScreenContainer({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        )
      ],
    );
  }
}
