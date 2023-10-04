import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../widgets/appbars/glorifi_appbar.dart';

class InsuranceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InsuranceAppBar(
      {Key? key, required this.title, this.iconVisibility = true})
      : super(key: key);

  final String title;
  final bool iconVisibility;

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return GlorifiAppBar(
      elevation: 0,
      title: title,
      trailing: iconVisibility
          ? Trailing(
              onTap: () {},
              icon: SvgPicture.asset(
                'assets/icons/message_icon.svg',
              ).paddingOnly(right: 10),
            )
          : null,
    );
  }
}
