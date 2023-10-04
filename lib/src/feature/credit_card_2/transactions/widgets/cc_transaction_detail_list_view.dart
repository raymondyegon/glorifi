import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CCTransactionDetailListView extends StatelessWidget {
  const CCTransactionDetailListView({
    Key? key,
    required this.icon,
    required this.title,
    required this.balance,
    required this.date,
    required this.status,
    required this.itemCount,
  }) : super(key: key);

  final List<IconData> icon;
  final List<String> title;
  final List<String> balance;
  final List<String> date;
  final List<String> status;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          ListView.separated(
            physics:
                const NeverScrollableScrollPhysics(), // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: Row(
                  children: [
                    Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                          color: GlorifiColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        icon[index],
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title[index],
                          style: captionSemiBold14Primary(
                              color: GlorifiColors.darkBlue),
                        ),
                        SizedBox(height: 4.0,),
                        Text(
                          date[index],
                          style: xSmallRegular12Primary(
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${balance[index]}",
                          style: captionSemiBold14Primary(color: GlorifiColors.darkBlue),
                        ),
                        SizedBox(height: 4.0,),
                        Text(
                          status[index],
                          style: xSmallRegular12Primary(color: GlorifiColors.darkBlue),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(),
          )
        ],
      ),
    );
  }
}
