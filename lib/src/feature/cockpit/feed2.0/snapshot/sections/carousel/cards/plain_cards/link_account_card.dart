import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_icon_button.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_top_part.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/snapshot_carousel_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/snapshot_carousel_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

class LinkAccountCard extends StatelessWidget {
  const LinkAccountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnapshotCarouselCard(
      topPart: CarouselCardTopPart(
        title: 'Want A Better Picture Of Your Finances?',
        description: 'Link your existing accounts.',
        svg: GlorifiAssets.dollar,
      ),
      notNow: () {
        SnapshotCarouselController _controller = Get.find<SnapshotCarouselController>();
        _controller.dismissCard(ACTION_CARD_KEY_LINK_ACCOUNTS);
      },
      bottomPart: [
        Spacer(),
        CarouselCardIconButton(
          buttonText: 'Link Account',
          onTap: () async {
            PlaidController _controller = Get.find<PlaidController>();
            await _controller.openPlaid();
          },
        ),
      ],
    );
  }
}
