import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class ClickableTile extends StatelessWidget {
  final String title;
  final double? amount;
  final Function onTap;

  const ClickableTile(
      {Key? key, required this.title, this.amount, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            child: InkWell(
                child: Container(
                    width: 1.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: GlorifiColors.white)),
                    padding: EdgeInsets.all(24.r),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: GlorifiColors.darkBlueTint[500],
                            ),
                          ),
                          if (amount != null)
                            Text(
                              "\$${amount!.toStringAsFixed(2)}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                        ])),
                onTap: () {
                  Future.delayed(Duration(milliseconds: 150));
                  onTap();
                })));
  }
}
