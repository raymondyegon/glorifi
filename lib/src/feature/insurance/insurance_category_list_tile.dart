import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../routes/app_pages.dart';
import 'insurance_category_tile.dart';
import 'model/insurance_category_model.dart';
import 'widgets/connect_to_insurance_web.dart';

class InsuranceCategoryListTile extends StatelessWidget {
  const InsuranceCategoryListTile({
    Key? key,
    required this.title,
    required this.insuranceCategoryItems,
  }) : super(key: key);

  final String title;
  final List<Items> insuranceCategoryItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 32.h,
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: headlineRegular21Secondary(
            color: GlorifiColors.biscayBlue,
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Column(
          children: insuranceCategoryItems.map((insuranceCategoryItem) {
            return InkWell(
              onTap: () {
                if(insuranceCategoryItem.vendor == 'bindable'){
                    Get.toNamed(Routes.continueCreateQuote, parameters: {
                      'title': insuranceCategoryItem.categoryName,
                      'vendor': insuranceCategoryItem.vendor,
                      'initialUrl': insuranceCategoryItem.vendorUrl ?? ''
                    });

                }
                else {
                  Get.to(ConnectToInsuranceWeb(
                    url: insuranceCategoryItem.vendorUrl,
                    vendor: insuranceCategoryItem.vendor,
                    title: insuranceCategoryItem.categoryName,
                    bindableUrl: insuranceCategoryItem.bindableUrl,
                  ));
                }
              },
              child: InsuranceCategoryTile(
                  title: insuranceCategoryItem.categoryName,
                  icon: insuranceCategoryItem.icon),
            );
          }).toList(),
        ),
      ],
    );
  }
}
