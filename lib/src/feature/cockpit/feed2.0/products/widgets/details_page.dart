import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/model/product_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/credit_cards_slider.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/head_item.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/insurance_options_slider.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/picture_content_item.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/products_buttons.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/quote_item.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/side_divider.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class DetailsPage extends StatelessWidget {
  final ProductModel model;
  final ScrollController? scrollController;
  final includeBottomPadding;
  final VoidCallback onEarlyAccessTap;
  final bool alreadyRequestedAccess;
  const DetailsPage(
      {Key? key,
      required this.model,
      this.scrollController = null,
      this.includeBottomPadding = true,
      required this.onEarlyAccessTap,
      required this.alreadyRequestedAccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlorifiColors.midnightBlue,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadItem(context,
                imageUrl: model.productHeader!.imageUrl,
                hint: model.productHeader!.hint,
                title: model.productHeader!.title,
                content: model.productHeader!.content,
                arriving: model.productHeader!.arrivingString),
            (model.imageUrl! == "")
                ? Container()
                : Image.asset(
                    model.imageUrl!,
                  ).paddingOnly(top: 51, left: 32, right: 32),
            if (model.secondaryHeaderTitle != null)
              Column(
                children: [
                  SideDivider(),
                  SizedBox(height: 40),
                  Text(
                    model.secondaryHeaderTitle!,
                    textAlign: TextAlign.center,
                    style: customGlorifiStyle(
                        fontFamily: 'Arvo',
                        weight: FontWeight.bold,
                        size: 28,
                        color: GlorifiColors.white),
                  ).paddingOnly(bottom: 40),
                  Text(
                    model.secondaryHeaderSubTitle!,
                    textAlign: TextAlign.center,
                    style: smallRegular16Primary(
                      color: GlorifiColors.white,
                    ),
                  ).paddingSymmetric(horizontal: 24),
                  if (model.productOptions != null)
                    InsuranceOptionsSlider(
                      productionOptionList: model.productOptions!,
                    ).paddingOnly(top: 30),
                ],
              ).paddingOnly(top: 100),
            // TODO: Icon list here
            if (model.productQuoteList != null)
              QuoteItem(
                productQuoteList: model.productQuoteList!,
              ),
            Column(
              children: model.productItems!.map((e) {
                return PictureContentItem(
                  imageUrl: e.imageUrl,
                  hint: e.hint,
                  title: e.title,
                  content: e.content,
                );
              }).toList(),
            ),
            if (model.productOptions != null &&
                model.secondaryHeaderTitle == null)
              CreditCardsSlider(
                productionOptionList: model.productOptions!,
              ).paddingOnly(bottom: 40),
            alreadyRequestedAccess
                ? _alreadyRequestedButton()
                : AccessButton(onEarlyAccessTap),
            if (model.footnote != null)
              Text(
                model.footnote!,
                style: xSmallRegular12Primary(color: GlorifiColors.white),
              ).paddingOnly(left: 24, right: 24, bottom: 20, top: 40),
            if (model.footnoteIconName != null)
              Image.asset(model.footnoteIconName!, width: 23, height: 25)
                  .paddingOnly(left: 24, bottom: 16)
          ],
        ),
      ).paddingOnly(bottom: includeBottomPadding ? 80 : 0),
    );
  }

  Widget _alreadyRequestedButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PrimaryButton(
        title: 'You’re On the list!',
        primaryColor: GlorifiColors.greenTint[50]!,
        textColor: GlorifiColors.greenTint[600]!,
        onTap: null,
      ),
    );
  }
}
