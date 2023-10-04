import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_icon_button.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_top_part.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/snapshot_carousel_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/snapshot_carousel_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

class AddAddressCard extends StatelessWidget {
  const AddAddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnapshotCarouselCard(
        topPart: CarouselCardTopPart(
          title: 'Add Your Home Address.',
          description: 'See your home property value over time.',
          svg: GlorifiAssets.home2Icon,
        ),
        notNow: () {
          SnapshotCarouselController _controller =
              Get.find<SnapshotCarouselController>();
          _controller.dismissCard(ACTION_CARD_KEY_ADD_ADDRESS);
        },
        bottomPart: [
          Spacer(),
          CarouselCardIconButton(
            buttonText: 'Add Address',
            onTap: () {
              SnapshotController _controller = Get.find<SnapshotController>();
              _controller.addAddress();
            },
          ),
        ]);
  }
}
