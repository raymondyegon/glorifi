import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../../font_style_global.dart';

class GlorifiAppBarDemo extends StatelessWidget {
  const GlorifiAppBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(title: "Glorifi"),
      body: SafeArea(
        child: Column(
          children: [
            GlorifiAppBar(
              title: "Accounts",
              trailing: Trailing(
                icon: Icon(Icons.check_circle_outline),
                onTap: () {},
                textStyle: captionBold14Primary(
                  color: GlorifiColors.lightRed,
                ),
              ),
            ),
            GlorifiAppBar(
              bgColor: GlorifiColors.white,
              title: "Accounts",
              trailing: Trailing(
                text: "Long CTA",
                onTap: () {},
              ),
            ),
            GlorifiAppBar(
              title: "Glorifi",
              leading: Leading(
                text: "Close",
                // onTap: () {},
              ),
              trailing: Trailing(
                text: "Long CTA",
                onTap: () {},
              ),
            ),
            GlorifiAppBar(
              title: "Glorifi",
              disableLeading: true,
            ),
            GlorifiAppBar(
              title: "Glorifi",
              disableLeading: true,
              trailing: Trailing(
                text: "Help",
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
