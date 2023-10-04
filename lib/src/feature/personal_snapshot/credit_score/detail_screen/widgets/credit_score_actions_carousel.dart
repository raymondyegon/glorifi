import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/circle_icon_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CreditScoreActionsCarousel extends StatelessWidget {
  const CreditScoreActionsCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _cards = [
      _card(
        GlorifiAssets.check,
        'On time payments',
        'Ensure you make all payments before the due date to improve your score',
        isFirst: true,
      ),
      _card(
        GlorifiAssets.creditCard,
        'Keep old card active',
        'Total age of your credit activity will boost your score',
        isLast: true,
      ),
    ];

    return Container(
      width: double.infinity,
      height: 148.h,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.66),
        padEnds: false,
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (BuildContext context, int itemIndex) {
          return _cards[itemIndex];
        },
      ),
    );
  }

  Widget _card(
    String icon,
    String title,
    String description, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: isFirst ? 20.w : 5.w,
        right: isLast ? 20.w : 5.w,
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      height: 148.h,
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleIconWidget(
          icon: icon,
        ),
        SizedBox(height: 18.h),
        Text(
          title,
          style: captionSemiBold14Primary(
            color: GlorifiColors.almostBlack,
          ),
        ),
        SizedBox(height: 4.h),
        Expanded(
          child: Text(
            description,
            style: tinySemiBold10Primary(
              color: GlorifiColors.textDarkBlue,
            ).copyWith(fontSize: 10),
          ),
        ),
      ]),
    );
  }
}
