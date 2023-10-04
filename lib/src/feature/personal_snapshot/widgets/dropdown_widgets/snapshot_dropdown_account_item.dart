import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

class SnapshotDropdownAccountItem extends StatelessWidget {
  final String label;
  final double balance;
  final Function onTap;

  SnapshotDropdownAccountItem(
      {Key? key,
      required this.label,
      required this.balance,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFD4DEF4), width: 0.5),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // left side
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: Color(0xFF444E60),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      balance.formatCurrencyWithZero(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Icon(
              Icons.chevron_right,
              size: 25,
              color: Color(0xFF152951),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
