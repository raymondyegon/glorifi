import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_top_part.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/snapshot_carousel_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/snapshot_carousel_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

import '../widgets/carousel_card_icon_button.dart';

class GetCreditScoreCard extends StatelessWidget {
  const GetCreditScoreCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnapshotCarouselCard(
      topPart: CarouselCardTopPart(
        title: 'Get Your Credit Score Today!',
        description:
            'We are retrieving your VantageScore from Equifax. It will not impact your credit score.',
        svg: GlorifiAssets.medalIcon,
      ),
      notNow: () {
        SnapshotCarouselController _controller =
            Get.find<SnapshotCarouselController>();
        _controller.dismissCard(ACTION_CARD_KEY_CREDIT_SCORE);
      },
      bottomPart: [
        Spacer(),
        CarouselCardIconButton(
          buttonText: 'Get Score',
          onTap: () {
            SnapshotController _controller = Get.find<SnapshotController>();
            _controller.enableCreditScore();
          },
        ),
      ],
    );
  }
}
