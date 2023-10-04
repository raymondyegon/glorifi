import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class AddExternalItemTile extends StatefulWidget {
  const AddExternalItemTile({
    Key? key,
    this.buttonText,
    this.onTap,
    this.isAddIcon,
    this.cardFor,
  }) : super(key: key);

  final buttonText;
  final Function()? onTap;
  final bool? isAddIcon;
  final String? cardFor;

  @override
  State<AddExternalItemTile> createState() => _AddExternalItemTileState();
}

class _AddExternalItemTileState extends State<AddExternalItemTile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return widget.cardFor == "Mortgage"
        ? InkWell(
            onTap: widget.onTap,
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.w),
              child: Row(
                children: [
                  Text(
                    widget.buttonText,
                    style: bodyBold18Primary(color: GlorifiColors.cornflowerBlue),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: loading
                ? () {}
                : () async {
                    try {
                      loading = true;
                      setState(() {});
                      await widget.onTap!();
                    } finally {
                      loading = false;
                      setState(() {});
                    }
                  },
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.w),
              child: Row(
                children: [
                  loading
                      ? Container(
                          width: 22.w,
                          height: 22.w,
                          child: CircularProgressIndicator(),
                        )
                      : SvgPicture.asset(
                          widget.isAddIcon! ? GlorifiAssets.gridAddIcon : GlorifiAssets.comet,
                          width: 22.w,
                        ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    widget.buttonText,
                    style: smallSemiBold16Primary(
                      color: GlorifiColors.cornflowerBlue,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
