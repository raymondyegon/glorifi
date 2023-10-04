import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/controller/accounts_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/controller/explore_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/widgets/explore_component.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExploreController());
    final accountController = Get.put(AccountsController());
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        key: Key("Explore"),
        backgroundColor: GlorifiColors.productsBgWhite,
        appBar: GlorifiAppBar(title: "Explore GloriFi"),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1024),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List<Widget>.generate(controller.exploreData.length,
                            (index) {
                          var content = controller.exploreData[index];
                          return ExploreComponent(
                            key: Key(content.category),
                            category: content.category,
                            contents: content.contents,
                            showProgress: false,
                            desc: content.desc,
                            arrowColor: GlorifiColors.biscayBlue,
                          ).paddingSymmetric(horizontal: 24.w);
                        }),
                      ],
                    )),
                SizedBox(
                  height: 32.h,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
