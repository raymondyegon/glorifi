import 'package:flutter/material.dart';

import 'card.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlorifiCard(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
