import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CloseAppBar extends StatefulWidget implements PreferredSizeWidget {
  CloseAppBar({Key? key})
      : preferredSize = Size.fromHeight(100),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CloseAppBarState createState() => _CloseAppBarState();
}

class _CloseAppBarState extends State<CloseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: GlorifiColors.lightWhite,
        centerTitle: true,
        actions: [
          Container(
              width: 100,
              margin: EdgeInsets.only(top: 50, right: 20),
              child: InkWell(
                  child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Close',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: GlorifiColors.cameraCancelRed,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  onTap: () {
                    Navigator.of(context).pop();
                  }))
        ],
        toolbarHeight: 100,
        elevation: 0,
        title: Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
              'GloriFi',
              textAlign: TextAlign.center,
              style: TextStyle(color: GlorifiColors.black, fontFamily: 'univers'),
            )));
  }
}
