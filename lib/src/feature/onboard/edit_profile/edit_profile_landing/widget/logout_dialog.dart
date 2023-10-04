import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class LogoutDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Function()? onLogoutConfirm;

  const LogoutDialog({
    Key? key,
    this.title = "Logout of GloriFi?",
    this.content,
    this.onLogoutConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = captionSemiBold14Primary();

    final Widget titleWidget = Text(title);
    final Widget? contentWidget = content != null ? Text(content!) : null;

    final cancelButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "Cancel",
          style: buttonTextStyle.copyWith(color: Colors.red),
        ));

    final logoutButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          onLogoutConfirm?.call();
        },
        child: Text(
          "Logout",
          style: buttonTextStyle.copyWith(color: GlorifiColors.biscayBlue),
        ));

    final actions = [cancelButton, logoutButton];

    return kIsWeb
        ? AlertDialog(
            title: titleWidget,
            content: contentWidget,
            actions: actions,
          )
        : Platform.isIOS
            ? CupertinoAlertDialog(
                title: titleWidget, content: contentWidget, actions: actions)
            : AlertDialog(
                title: titleWidget,
                content: contentWidget,
                actions: actions,
              );
  }
}
