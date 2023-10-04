import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../font_style_global.dart';
import '../../utils/adaptive/adaptive_sizing.dart';

class TotalDebtChart extends StatelessWidget {
  TotalDebtChart(
      {Key? key,
      this.creditDebt = 0,
      this.installmentDebt = 0,
      this.sizingInfo,
      this.emptyState = false})
      : super(key: key);

  final double creditDebt;
  final double installmentDebt;
  final bool emptyState;
  final AdaptiveSizingInfo? sizingInfo;

  final TextStyle bubbleTextStyle = bodyBold18Primary(
    color: GlorifiColors.white,
  );

  @override
  Widget build(BuildContext context) {
    bool installmentDebtIsLarger = true;
    double creditDebtBubbleSize = 112.w;
    double installmentDebtSize = 144.w;

    if (creditDebt.toInt() == installmentDebt.toInt()) {
      creditDebtBubbleSize = 120.w;
      installmentDebtSize = 120.w;
    } else if (creditDebt > installmentDebt) {
      creditDebtBubbleSize = 144.w;
      installmentDebtSize = 112.w;
      installmentDebtIsLarger = false;
    }
    if (creditDebt > 0 && installmentDebt == 0) {
      creditDebtBubbleSize = 144.w;
    }

    if (emptyState) {
      installmentDebtSize = 144.w;
    }
    final LinearGradient installmentGradient = LinearGradient(
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
        transform: GradientRotation(-4.2),
        colors: [
          GlorifiColors.gradientRed,
          GlorifiColors.gradientLightRed.withOpacity(0.75),
        ],
        stops: [
          0.1,
          0.75
        ]);

    final LinearGradient creditGradient = LinearGradient(
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
        transform: GradientRotation(-4.2),
        colors: [
          GlorifiColors.gradientRed,
          GlorifiColors.gradientMediumRed.withOpacity(0.75),
        ],
        stops: [
          0.2,
          1
        ]);

   return Column(
     mainAxisAlignment: MainAxisAlignment.end,
     children: [
       Row(
         crossAxisAlignment: CrossAxisAlignment.end,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           if (emptyState || installmentDebt > 0)
             Container(
               height: installmentDebtSize,
               width: installmentDebtSize,
               margin: EdgeInsets.only(
                   bottom: installmentDebtIsLarger ? 64.h : 24.h),
               padding: EdgeInsets.all(16.sp),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 gradient: installmentGradient,
                 boxShadow: [
                   BoxShadow(
                     blurRadius: 55,
                     offset: Offset(0, 13),
                     color: GlorifiColors.black.withOpacity(0.25),
                   ),
                 ],
               ),
               child: !emptyState
                   ? Center(
                       child: FittedBox(
                         fit: BoxFit.fitWidth,
                         child: Text(
                           installmentDebt.formatSimpleCurrencyZeroDecimal(),
                           style: bubbleTextStyle,
                         ),
                       ),
                     )
                   : Container(),
             ),
           if (emptyState || creditDebt > 0)
             Container(
               height: creditDebtBubbleSize,
               width: creditDebtBubbleSize,
               margin: EdgeInsets.only(
                   bottom: installmentDebtIsLarger ? 24.h : 64.h),
               // padding: EdgeInsets.all(16.sp),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 boxShadow: [
                   BoxShadow(
                     blurRadius: 55,
                     offset: Offset(0, 13),
                     color: GlorifiColors.black.withOpacity(0.25),
                   ),
                 ],
                 gradient: creditGradient,
               ),
               child: !emptyState
                   ? Center(
                 child: FittedBox(
                   fit: BoxFit.fitWidth,
                   child: Text(
                     creditDebt.formatSimpleCurrencyZeroDecimal(),
                     style: bubbleTextStyle,
                   ),
                 ),
               )
                   : Container(),
             ),
         ],
       ),
       Container(
         alignment:
             sizingInfo!.isDesktop ? Alignment.centerLeft : Alignment.center,
         child: Row(
           mainAxisAlignment: sizingInfo!.isDesktop
               ? MainAxisAlignment.center
               : MainAxisAlignment.center,
           children: [
             if (installmentDebt > 0 || emptyState)
               Padding(
                 padding: EdgeInsets.only(right: 20.0.w),
                 child: DebtChartLabelWidget(
                   gradient: LinearGradient(
                       begin: FractionalOffset.centerLeft,
                       end: FractionalOffset.centerRight,
                       transform: GradientRotation(-4.2),
                       colors: [
                         GlorifiColors.gradientRed,
                         GlorifiColors.gradientLightRed.withOpacity(0.75),
                       ],
                       stops: [
                         0,
                         1
                       ]),
                   text: 'Installment Debt',
                 ),
               ),
             if (creditDebt > 0 || emptyState)
               DebtChartLabelWidget(
                 gradient: LinearGradient(
                     begin: FractionalOffset.centerLeft,
                     end: FractionalOffset.centerRight,
                     transform: GradientRotation(-4.2),
                     colors: [
                       GlorifiColors.gradientMediumRed,
                       GlorifiColors.gradientDarkRed.withOpacity(0.75),
                     ],
                     stops: [
                       0,
                       1
                     ]),
                 text: 'Credit Debt ',
               )
           ],
         ),
       )
     ],
   );
  }
}

class DebtChartLabelWidget extends StatelessWidget {
  const DebtChartLabelWidget({
    Key? key,
    required this.gradient,
    required this.text,
  }) : super(key: key);

  final LinearGradient gradient;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            gradient: gradient,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: captionSemiBold14Primary(
            color: GlorifiColors.midnightBlueColor,
          ),
        ),
      ],
    );
  }
}
