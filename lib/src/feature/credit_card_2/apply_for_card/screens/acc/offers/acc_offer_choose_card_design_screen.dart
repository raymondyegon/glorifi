import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_credit_card_designs_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ACCChooseCardDesignScreen extends StatefulWidget {
  const ACCChooseCardDesignScreen({Key? key}) : super(key: key);

  @override
  State<ACCChooseCardDesignScreen> createState() => _ACCChooseCardDesignScreenState();
}

class _ACCChooseCardDesignScreenState extends State<ACCChooseCardDesignScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCChooseCreditCardDesign,
      children: _content(creditCards[selectedIndex]),
      onContinue: () async {
        Get.toNamed(Routes.accAcceptCardAgreement);
      },
    );
  }

  List<Widget> _content(ACCCreditCardDesignModel creditCard) {
    return <Widget>[
      /// Credit Card Design Image
      Image.asset(
        creditCard.path,
        fit: BoxFit.cover,
      ),
      SizedBox(height: 24.h),
      Text(
        creditCard.cardName,
        style: smallBold16Primary(
          color: GlorifiColors.darkBlue,
        ),
      ),
      SizedBox(height: 16.h),
      Container(
        constraints: BoxConstraints(
          minHeight: 92.h,
        ),
        child: Text(
          creditCard.cardDescription,
          style: captionRegular14Primary(
            color: GlorifiColors.darkGrey80,
          ),
        ),
      ),
      SizedBox(height: 41.h),
      _buildCreditCardPreview(),
    ];
  }

  _buildCreditCardPreview() {
    return Row(
      children: List.generate(
        creditCardsPreview.length,
        _creditCardPreviewCard,
      ),
    );
  }

  GestureDetector _creditCardPreviewCard(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: creditCardsPreview.length - 1 == index ? 0 : 15.w),
        decoration: isCardSelected(index) ? _selectedCardDesign() : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              creditCardsPreview[index],
              height: 63.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
            Visibility(
              visible: isCardSelected(index),
              child: Image.asset(
                GlorifiAssets.greenCheckIconRounded,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isCardSelected(int index) {
    return selectedIndex == index;
  }

  BoxDecoration _selectedCardDesign() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        width: 3,
        color: GlorifiColors.white,
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 9,
          color: GlorifiColors.black.withOpacity(.45),
        )
      ],
    );
  }
}
