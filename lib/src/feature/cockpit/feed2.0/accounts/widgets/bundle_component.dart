import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/bundles/controller/bundle_controller.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_model.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_type.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/widgets/component_title.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/widgets/content_tile.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class BundleComponent extends StatelessWidget {
  final List<BundleModel> bundleList;
  const BundleComponent({
    required this.bundleList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(
          title: TextConstants.bundles_title,
          subTitle: TextConstants.bundles_subtitle,
        ),
        SizedBox(
          height: 30.h,
        ),
        if (bundleList.isNotEmpty)
          ContentTile(
            onTap: () {
              Get.toNamed(
                Routes.bundlesScreen,
                arguments: {
                  BundleController.bundleTypeKey: BundleType.HomeFront
                },
              );
            },
            title: bundleList[0].name,
            subTitle: "Most Savings",
            asset: GlorifiAssets.smart_home,
            showProgress: true,
            progress:
                "${bundleList[0].completed}/${bundleList[0].total} completed",
            progressColor: GlorifiColors.darkBlue,
            arrowColor: GlorifiColors.darkBlue,
          ),
        if (bundleList.isNotEmpty)
          ContentTile(
            onTap: () {
              Get.toNamed(
                Routes.bundlesScreen,
                arguments: {BundleController.bundleTypeKey: BundleType.Protect},
              );
            },
            title: bundleList[1].name,
            subTitle: "Most Secure",
            asset: GlorifiAssets.shieldLock,
            showProgress: true,
            progress:
                "${bundleList[1].completed}/${bundleList[1].total} completed",
            progressColor: GlorifiColors.darkBlue,
            arrowColor: GlorifiColors.darkBlue,
          ),
        if (bundleList.isNotEmpty)
          ContentTile(
            onTap: () {
              Get.toNamed(
                Routes.bundlesScreen,
                arguments: {BundleController.bundleTypeKey: BundleType.Heroes},
              );
            },
            title: bundleList[2].name,
            subTitle: "Most Popular",
            asset: GlorifiAssets.bolt,
            showProgress: true,
            progress:
                "${bundleList[2].completed}/${bundleList[2].total} completed",
            progressColor: GlorifiColors.darkBlue,
            arrowColor: GlorifiColors.darkBlue,
          )
      ],
    );
  }
}
