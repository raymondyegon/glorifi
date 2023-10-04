import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_deposit_account.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_error_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class OAOProductSelection extends GetView<OAOController> {
  const OAOProductSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.cdProducts.isNotEmpty
            ? GetBuilder<OAOController>(
                builder: (_) => OAOContainer(
                  info: OAOScreensInfo.OAOProductSelection,
                  children: [
                    ...controller.cdProducts
                        .map(
                          (item) => _SingleTermOption(
                            onChange: () {
                              controller.selectProduct(item);
                            },
                            item: item,
                            isSelected:
                                controller.application.selectedProduct?.name ==
                                    item.name,
                          ),
                        )
                        .toList()
                  ],
                  onContinue: controller.application.selectedProduct == null
                      ? () {
                          showSnackBar('Please select one option');
                        }
                      : () {
                          return controller.onBeginApplication(
                              controller.application.selectedProduct!);
                        },
                  disclosureWidget: Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: OAOFooterNote(
                      title: 'Please Note: ',
                      plainText:
                          'Your maturity date and annual percentage yield will be determined when you fund your account. If you withdraw your funds prior to the maturity date, a penalty may apply for early withdrawal. Interest compounds daily and will be paid monthly.',
                    ),
                  ),
                ),
              )
            : Center(child: GlorifiSpinner());
      }),
    );
  }
}

class _SingleTermOption extends StatelessWidget {
  final OAODepositAccount item;
  final bool isSelected;
  final Function() onChange;

  const _SingleTermOption({
    Key? key,
    this.isSelected = false,
    required this.onChange,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        border: Border.all(color: GlorifiColors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          onTap: onChange,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? GlorifiColors.green
                            : GlorifiColors.greyEC,
                      ),
                      duration: Duration(milliseconds: 300),
                    ),
                    SizedBox(width: 16),
                    Text(
                      item.term,
                      style: bodySemiBold18Primary(
                        color: GlorifiColors.cornflowerBlue,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interest Rate',
                      style: xSmallSemiBold12Primary(
                          color: GlorifiColors.darkGrey80),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'APY',
                      style: xSmallSemiBold12Primary(
                          color: GlorifiColors.darkGrey80),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.interestRate,
                      style: xSmallSemiBold12Primary(
                          color: GlorifiColors.cornflowerBlue),
                    ),
                    SizedBox(height: 2),
                    Text(
                      item.apy,
                      style: xSmallSemiBold12Primary(
                          color: GlorifiColors.cornflowerBlue),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
