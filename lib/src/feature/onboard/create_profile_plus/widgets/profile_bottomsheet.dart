import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_button.dart';

showReasonBottomsheet(BuildContext context, String title) {
  return showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title),
          profileNextButton(context, "Got it!", Container(), () {
            Navigator.pop(context);
          })
        ],
      );
    },
  );
}
