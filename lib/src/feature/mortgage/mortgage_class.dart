import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../font_style_global.dart';
import '../../utils/glorifi_colors.dart';
import '../credit_card/widgets/add_external_item_tile.dart';

class MortgageLinkAccount extends StatelessWidget {
  const MortgageLinkAccount({Key? key, required this.isWeb}) : super(key: key);

  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    return isWeb
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Text(
                'My Loan',
                style: bodyRegular18Secondary(
                  color: GlorifiColors.cornflowerBlue,
                ),
              ),
              SizedBox(height: 25.h),
              AddExternalItemTile(
                buttonText: "+ Get New Loan",
                onTap: () {},
                cardFor: "Mortgage",
              ),
              SizedBox(height: 50.h),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Text(
                'Applications In Progress',
                style: bodyRegular18Secondary(
                  color: GlorifiColors.cornflowerBlue,
                ),
              ),
              SizedBox(height: 25.h),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Application #',
                                style: smallSemiBold16Primary(
                                  color: GlorifiColors.cornflowerBlue,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'Started On  02/02/2022',
                                style: smallSemiBold16Primary(
                                  color: GlorifiColors.cornflowerBlue,
                                ),
                              )
                            ],
                          ),
                          Text(
                            'In Progress',
                            style: smallSemiBold16Primary(
                              color: GlorifiColors.bloodOrange,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
              SizedBox(height: 50.h),
            ],
          );
  }
}
