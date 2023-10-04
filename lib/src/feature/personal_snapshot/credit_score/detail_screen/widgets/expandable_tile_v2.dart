import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ExpandableTileV2 extends StatefulWidget {
  final String title;
  final String description;
  final Widget child;
  final Color dotColor;

  const ExpandableTileV2({
    Key? key,
    required this.title,
    required this.description,
    required this.child,
    this.dotColor = GlorifiColors.blueD4DE,
  }) : super(key: key);

  @override
  State<ExpandableTileV2> createState() => _ExpandableTileV2State();
}

class _ExpandableTileV2State extends State<ExpandableTileV2> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  isExpanded = !isExpanded;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: 12.w,
                    right: 22.w,
                    top: 16.h,
                    bottom: 16.h,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: widget.dotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title),
                            Text(widget.description),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: Duration(milliseconds: 300),
                        child: SvgPicture.asset(
                          GlorifiAssets.chevronDown,
                          color: GlorifiColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              alignment: Alignment.topCenter,
              duration: Duration(
                milliseconds: 300,
              ),
              child: Container(
                decoration: BoxDecoration(),
                height: isExpanded ? null : 0,
                width: double.infinity,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
