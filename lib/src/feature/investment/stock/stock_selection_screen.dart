import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/investment/models/stock_selection_model.dart';
import 'package:glorifi/src/feature/investment/stock/stock_selection_card.dart';
import 'package:glorifi/src/feature/investment/widgets/submit_button.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class StockSelectionScreen extends StatelessWidget {
  const StockSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, left: 20.h, right: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose your first stock",
                      style: textStyleHeading,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "Choose from one of the stocks below, or search for your own selection.",
                      style: textStyleDescription,
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      "Subject to our Terms & Conditions",
                      style: textStyleSubHeading,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    _buildStockListView(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: GlorifiColors.sliderBgColor,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubmitButton(buttonText: "Opt Out", onTap: () {}),
                    SizedBox(
                      width: 70.h,
                    ),
                    SubmitButton(buttonText: "Next", onTap: () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildStockListView() {
    List activitiesList = List.filled(
      6,
      StockSelectionModel(
        id: 1,
        image: "assets/images/flutter_logo.png",
      ),
    );

    return Expanded(
      child: GridView.builder(
        itemBuilder: (context, index) {
          return StockSelectionCard(
            stockSelectionModel: activitiesList[index],
            currentIndex: index,
          );
        },
        itemCount: activitiesList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
