import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/bundles/controller/bundle_controller.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_type.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/model/explore_data_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/widgets/component_title.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/widgets/content_tile.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../../../routes/app_pages.dart';
import '../../accounts/controller/accounts_controller.dart';

class ExploreComponent extends StatelessWidget {
  ExploreComponent(
      {Key? key,
      required this.category,
      this.desc,
      required this.contents,
      this.showProgress = false,
      this.arrowColor = GlorifiColors.bloodOrange})
      : super(key: key);
  final String category;
  final String? desc;
  final List<Contents> contents;
  final bool showProgress;
  var arrowColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (category.isNotEmpty)
          ComponentTitle(
            title: category,
            subTitle: desc,
            showSubTitle: desc != null,
          ),
        if (category.isNotEmpty)
          SizedBox(
            height: 16.h,
          ),
        ...List.generate(contents.length, (index) {
          return Obx(
            () => ContentTile(
                asset: contents[index].asset,
                title: contents[index].title,
                subTitle: contents[index].subtitle,
                showProgress: contents[index].showSubtitle!,
                progress:
                    '$index/6 completed',
                showArrow: contents[index].route !=
                    null, //add static progress data for UI, currently there is no field inside contents model.
                arrowColor: arrowColor,
                isLoading: controller.isLoading.value,
                onTap: () {
                  if (contents[index].route == Routes.myBanking) {
                    Get.toNamed(Routes.openBankAccount);
                  } else if (contents[index].route ==
                      Routes.brokerageMainPage) {
                    controller.notifyEmailStatus("Investments", "");
                  } else if (contents[index].route ==
                      Routes.creditCardComingSoonScreen) {
                    controller.notifyEmailStatus("Credit Card", "");
                  } else {
                    var args = null;
                    if (category.toLowerCase().contains('glorifi bundle')) {
                      args = {
                        BundleController.bundleTypeKey:
                            BundleTypeExtension.toBundleType(
                                contents[index].args ?? "")
                      };
                    }
                    if (contents[index].route != null) {
                      Get.toNamed(contents[index].route!, arguments: args);
                    }
                    
                  }
                }),
          );
        })
      ],
    ).paddingOnly(top: category.isNotEmpty ? 32.h : 0.0);
  }
}
