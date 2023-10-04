import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_text_styles.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class SeeAllProductsWidget extends StatelessWidget {
  final Function()? onTap;

  const SeeAllProductsWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: GlorifiValues.smallPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                "See all GloriFi products",
                style: sans16Style.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: GlorifiValues.smallMargin),
            Icon(
              Icons.arrow_right_alt,
              color: GlorifiColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
