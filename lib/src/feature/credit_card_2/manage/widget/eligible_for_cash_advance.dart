import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/model/credit_limit_view_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CreditLimitAndAprDetails extends StatelessWidget {
  const CreditLimitAndAprDetails(
      {Key? key,
      required this.itemCount,
      required this.item,
      required this.title})
      : super(key: key);

  final String title;
  final int itemCount;
  final CreditLimitModel item;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: font22(color: Color(0xFF031509)),
      ),
      SizedBox(height: 32),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: index == 0
                ? EdgeInsets.only(bottom: 18)
                : EdgeInsets.only(bottom: 18, top: 18),
            child: Row(
              children: [
                Text(
                  index == 0
                      ? "Available Credit"
                      : index == 1
                          ? "Credit Limit"
                          : "APR",
                  style: captionSemiBold14Primary(
                      color: GlorifiColors.textDarkBlue),
                ),
                Spacer(),
                Text(
                  index == 0
                      ? item.availableCreditString
                      : index == 1
                          ? item.creditLimitString
                          : item.aprString,
                  style: captionBold14Primary(color: Color(0xFF303437)),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
          );
        },
      ),
    ]);
  }
}
