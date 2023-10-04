import 'package:flutter/material.dart';
import '../widgets/carousel_card_top_part.dart';
import '../widgets/snapshot_carousel_card.dart';

class HomeValueCard extends StatelessWidget {
  const HomeValueCard({Key? key}) : super(key: key);

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
                "Home Value Card",
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
