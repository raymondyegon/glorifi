import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/account_settings/ebs_account_settings_screen.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class EBSContainer extends StatelessWidget {
  final String title;
  final TextStyle? appbarTextStyle;
  final List<Widget> children;
  final bool showSettings;
  final bool showAppbarShadow;
  final Color screenBackground;

  const EBSContainer({
    required this.title,
    required this.children,
    this.showSettings = true,
    this.showAppbarShadow = true,
    this.screenBackground = GlorifiColors.bgColor,
    this.appbarTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          backgroundColor: screenBackground,
          appBar: GlorifiAppBar(
            elevation: showAppbarShadow ? 5 : 0,
            title: title,
            textStyle: appbarTextStyle,
            trailing: showSettings
                ? Trailing(
                    icon: SvgPicture.asset(
                      "assets/images/profile_settings.svg",
                      width: 20,
                      height: 20,
                      color: GlorifiColors.cornflowerBlue,
                    ),
                    onTap: () {
                      Get.to(() => EBSAccountSettingsScreen());
                    })
                : null,
          ),
          body: Column(
            children: [...children],
          ),
        );
      },
    );
  }
}
