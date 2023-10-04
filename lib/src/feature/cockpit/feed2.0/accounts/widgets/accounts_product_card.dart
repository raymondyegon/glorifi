import 'package:flutter/material.dart';

class AccountsProductCard extends StatelessWidget {
  final VoidCallback onTap;
  final String imageName;

  const AccountsProductCard(
      {Key? key, required this.onTap, required this.imageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // shhhhh. Don't tell anyone this is just a PNG from Figma instead of native.
      // TODO: Implement this natively
      child: Image.asset(imageName, fit: BoxFit.cover),
      onTap: onTap,
    );
  }
}
