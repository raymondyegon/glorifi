import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/credit_card_2/activate_physical_card/controller/cc_activate_physical_card_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

Widget CreditCardLastFourDigitsTextField(
        CCActivatePhysicalCardController controller) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8.0),
              child: Text(
                "Last four digits",
                style: xSmallRegular12Primary(color: GlorifiColors.darkGrey80),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 12.0),
              child: TextField(
                autofocus: true,
                obscureText: true,
                onChanged: (value) {
                  controller.validate(value);
                },
                cursorColor: GlorifiColors.darkBlue,
                style: smallRegular16Primary(color: GlorifiColors.darkBlue),
                obscuringCharacter: '#',
                maxLength: 4,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 12),
                    counterText: "",
                    border: InputBorder.none,
                    hintText: ""),
              ),
            ),
          ],
        ),
      ),
    );
