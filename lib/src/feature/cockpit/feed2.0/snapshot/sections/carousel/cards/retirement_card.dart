import 'package:flutter/material.dart';
import 'widgets/carousel_card_top_part.dart';
import 'widgets/snapshot_carousel_card.dart';

class RetirementCard extends StatelessWidget {
  const RetirementCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnapshotCarouselCard(
      isGraph: true,
      topPart: CarouselCardTopPart(
        svg: '',
        customContent: Column(
          children: [
            Center(
              child: Text(
                "Retirement Card",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
