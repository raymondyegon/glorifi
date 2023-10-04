import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/link_more_accounts_card/last_linked_account_logo_widget.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_icon_button.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_top_part.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/not_not_button.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/snapshot_carousel_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/snapshot_carousel_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/buttons/custom_async_button.dart';

class LinkMoreAccounts extends StatelessWidget {
  const LinkMoreAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnapshotCarouselCard(
        topPart: CarouselCardTopPart(
          title: 'Great Start! Link More Accounts.',
          description: 'You can add as many accounts as you want.',
          svg: GlorifiAssets.buildingBank,
        ),
        notNow: () {
          SnapshotCarouselController _controller =
              Get.find<SnapshotCarouselController>();
          _controller.dismissCard(ACTION_CARD_KEY_LINK_MORE_ACCOUNTS);
        },
        bottomPart: [
          Spacer(),
          CarouselCardIconButton(
            buttonText: 'Link Account',
            onTap: () async {
              PlaidController _controller = Get.put(PlaidController());
              await _controller.openPlaid();
            },
          ),
        ]);
  }
}
