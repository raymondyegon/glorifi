import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/policy_detail/widget/policy_text_style.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class AddressTile extends StatelessWidget {
  const AddressTile(
      {Key? key,
      required this.firstHeading,
      required this.secondHeading,
      required this.firstData,
      required this.secondData})
      : super(key: key);

  final String firstHeading, secondHeading, firstData, secondData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(firstHeading,
                      style: PolicyTextStyle.textStyleAddress),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    secondHeading,
                    style: PolicyTextStyle.textStyleAddress,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.r),
                    child: Text(
                      firstData,
                      style: PolicyTextStyle.textStyleAddressData,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    secondData,
                    style: PolicyTextStyle.textStyleAddressData,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
