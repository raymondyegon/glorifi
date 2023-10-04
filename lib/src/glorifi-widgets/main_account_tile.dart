import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/model/personal_snapshot/single_account_item_model.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/custom_async_button.dart';
import '../font_style_global.dart';
import '../model/personal_snapshot/total_debt_detail_model.dart';
import '../utils/glorifi_colors.dart';
import '../widgets/tiles/account_tile.dart';
import '../widgets/tiles/expandable_two_line_tile/expandable_tile_controller.dart';

class MainAccountTile extends StatelessWidget {
  MainAccountTile({required this.data});

  final MainAccountTileData data;

  final ExpandableTileController controller =
      Get.put(ExpandableTileController(), tag: UniqueKey().toString());

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];

    items.add(Text(
      data.title,
      style: captionBold14Primary(
        color: GlorifiColors.midnightBlueColor,
      ).copyWith(
        height: 1.3.h
      ),
      maxLines: 2,
    ));

    bool _hasButton = data.buttonText != null;

    return Obx(
      () => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 20.h,),
        width:double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r), //border corner radius
          boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 10, // blur radius
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: controller.toggle,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items,
                      ),
                    ),
                    SizedBox(width: 20),
                    AnimatedRotation(
                      turns: controller.isExpanded.isTrue ? 0 : 0.5,
                      duration: Duration(milliseconds: 300),
                      child: SvgPicture.asset(
                        'assets/icons/chevron_up.svg',
                        color: GlorifiColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              alignment: Alignment.topCenter,
              duration: Duration(
                milliseconds: 300,
              ),
              child: Container(
                decoration: BoxDecoration(),
                height: controller.isExpanded.isTrue ? null : 0,
                width: double.infinity,
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: GlorifiColors.superLightGrey,
                      thickness: 1,
                    ),
                    ListView.builder(
                        itemCount: data.items.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          var item = data.items[index];

                          return Column(
                            children: [
                              AccountTile(
                                  title: item is SingleAccountItemModel
                                      ? item.name: (item as SingleDebtAccount).name,
                                  desc: item is SingleAccountItemModel
                                      ? item.label: (item as SingleDebtAccount).label,
                                  amount: item is SingleAccountItemModel
                                      ? item.balance: (item as SingleDebtAccount).balance),
                              Divider(
                                height: 1,
                                color: GlorifiColors.superLightGrey,
                                thickness: 1,
                              ),
                            ],
                          );
                        }),
                    if (_hasButton)
                      CustomAsyncButton(
                        height: 64,
                        onTap: data.buttonAction,
                        child: Center(
                          child: Text(
                            data.buttonText!,
                            style: captionBold14Primary(
                              color: GlorifiColors.midnightBlueColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainAccountTileData {
  MainAccountTileData({
    required this.title,
    required this.items,
    this.buttonText,
    this.buttonAction,
  });

  // SingleDebtAccount
  // SingleAccountItemModel
  final String title;
  final List<Object> items;
  final String? buttonText;
  final VoidCallback? buttonAction;
}
