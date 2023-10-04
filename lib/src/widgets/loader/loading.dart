import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/widgets/containers/elevated_container.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ElevatedContainer(
        bgColor: GlorifiColors.midnightBlue,
        padding: EdgeInsets.all(GlorifiValues.margin),
        child: CircularProgressIndicator(
          color: GlorifiColors.vividSkyBlue,
        ),
      ),
    );
  }
}
