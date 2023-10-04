import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CreditActivityItem {
  final String institution;
  final String product;
  final String status;
  final double amount;
  final String logo;

  CreditActivityItem(
      {required this.institution,
      required this.product,
      required this.status,
      this.amount = 0,
      this.logo = GlorifiAssets.bankLogo});
}

class CreditActivityWidget extends StatelessWidget {
  const CreditActivityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CreditActivityItem> items = [
      CreditActivityItem(
        institution: 'Chase bank',
        product: 'Consumer loan',
        status: 'Active',
        amount: 123,
      ),
      CreditActivityItem(
        institution: 'Chase bank',
        product: 'Consumer loan',
        status: 'Active',
        amount: 123,
      ),
      CreditActivityItem(
        institution: 'Chase bank',
        product: 'Consumer loan',
        status: 'Active',
        amount: 123,
      ),
      CreditActivityItem(
        institution: 'Chase bank',
        product: 'Consumer loan',
        status: 'Active',
        amount: 126543,
      ),
      CreditActivityItem(
        institution: 'Chase bank',
        product: 'Consumer loan',
        status: 'Active',
        amount: 123.05,
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: GlorifiColors.white,
            border: Border.all(
              color: GlorifiColors.lightGrey,
            ),
          ),
          child: Column(children: [
            ...items.map((e) => CreditActivityTile(item: e)).toList(),
            Material(
              color: Colors.transparent,
              child: InkWell(
                  //TODO load more
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Center(
                      child: Text(
                        'See more activity',
                        style: captionSemiBold14Primary(
                          color: GlorifiColors.blueIcon,
                        ),
                      ),
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}

class CreditActivityTile extends StatelessWidget {
  final CreditActivityItem item;
  final bool showBottomBorder;

  const CreditActivityTile({Key? key, required this.item, this.showBottomBorder = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        //TODO show detail ?
        onTap: () {},
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 18,
              ),
              child: Row(children: [
                Image.asset(
                  item.logo,
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.institution,
                            style: captionBold14Primary(color: GlorifiColors.almostBlack),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          item.amount.formatSimpleCurrencyWithDynamicDecimal(),
                          style: captionBold14Secondary(color: GlorifiColors.almostBlack),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.product,
                            style: tinySemiBold10Primary(
                              color: GlorifiColors.textDarkBlue,
                            ).copyWith(fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          item.status,
                          style: tinyRegular10Secondary(
                            color: GlorifiColors.greenStatus,
                          ).copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ))
              ]),
            ),
            if (showBottomBorder)
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Divider(
                  height: 1,
                  color: GlorifiColors.lighterGrey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
