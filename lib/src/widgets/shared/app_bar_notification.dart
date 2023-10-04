import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarNotification extends StatelessWidget with PreferredSizeWidget {
  const AppBarNotification({
    Key? key,
    this.title,
    this.notificationIcon = false,
  }) : super(key: key);

  final String? title;
  final bool notificationIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ''),
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/images/Temp-Logo.svg',
          width: 155,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        notificationIcon
            ? Container(
                padding: const EdgeInsets.only(right: 20),
                child: Stack(
                  children: <Widget>[
                    const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 40,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
