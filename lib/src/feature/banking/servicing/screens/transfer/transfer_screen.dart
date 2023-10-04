// ignore_for_file: use_raw_strings

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_review.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_account_select.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_success.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/widgets/selected_account_glorifi.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/widgets/selected_account_linked.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class TransferScreen extends GetView<TransferController> {
  static const routeName = '/money_transfer';
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Format to US Currency Dollar Format

    Get.put(TransferController());
    //Gesture Detector detects any taps outside of Amount Field to hide Keyboard
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Transfer",
            style: TextStyle(
              color: Color(0xFF131A3D),
              fontFamily: "OpenSans",
              fontSize: 20,
            ),
          ),
          iconTheme: IconThemeData(
            color: Color(0xFF131A3D), //change your color here
          ),
          backgroundColor: Color(0xFFE5E5E5),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            color: Color(0xFFE5E5E5),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Obx(
                  () => TextField(
                    controller: controller.amountController.value,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    onChanged: (val) {
                      controller.transferAmount.value =
                          double.parse(val.replaceAll('\$', ''));
                    },
                    inputFormatters: [
                      CurrencyTextInputFormatter(symbol: "\$"),
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: '\$0',
                      hintStyle: TextStyle(
                        color: Color(0xFFD2D3D4),
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xFF131A3D),
                      fontSize: 80,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Divider(
                  color: Color(0xFFDEDEDE),
                  thickness: 4,
                  indent: 20,
                  height: 80,
                  endIndent: 20,
                ),
                //"From" Row
                InkWell(
                  onTap: () {
                    Get.to(
                      () => TransferAccountSelect(
                        fromOrTo: "from",
                      ),
                    );
                    //This ensures you dont send API request again if you have already
                    controller.accountsFetched.value == false
                        ? controller.mapEligibleAccountsData()
                        : null;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA5A5A5),
                        ),
                      ),
                      Obx(
                        //Check if an Account has been Selected
                        //If so display Selected Account Information
                        () {
                          if (controller.selectedGlorifiAccountFrom!.value !=
                                  null &&
                              controller.selectedFromAccountType.value ==
                                  "Glorifi") {
                            return SelectedAccountGlorifi(
                              fromOrTo: "from",
                            );
                          }
                          if (controller.selectedLinkedAccountFrom!.value !=
                                  null &&
                              controller.selectedFromAccountType.value ==
                                  "Linked") {
                            return SelectedAccountLinked(
                              fromOrTo: "from",
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF1F3B73),
                      )
                    ],
                  ),
                ),

                //End "From" Row

                // Icon w/ Divider
                Container(
                  margin: const EdgeInsets.only(
                    right: 20,
                    top: 25,
                    bottom: 30,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        GlorifiAssets.iconSwitch,
                        width: 40.w,
                        height: 40.h,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFDEDEDE),
                                width: 4.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // End Icon w/ Divider
                //"To" Row
                InkWell(
                  onTap: () {
                    Get.to(
                      () => TransferAccountSelect(
                        fromOrTo: "to",
                      ),
                    );
                    //This ensures you dont send API request again if you have already
                    controller.accountsFetched.value == false
                        ? controller.mapEligibleAccountsData()
                        : null;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA5A5A5),
                        ),
                      ),
                      Obx(
                        //Check if an Account has been Selected
                        //If so display Selected Account Information
                        () {
                          if (controller.selectedGlorifiAccountTo!.value !=
                                  null &&
                              controller.selectedToAccountType.value ==
                                  "Glorifi") {
                            return SelectedAccountGlorifi(
                              fromOrTo: "to",
                            );
                          }
                          if (controller.selectedLinkedAccountTo!.value !=
                                  null &&
                              controller.selectedToAccountType.value ==
                                  "Linked") {
                            return SelectedAccountLinked(
                              fromOrTo: "to",
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF1F3B73),
                      )
                    ],
                  ),
                ),
                //End "To" Row
                Divider(
                  color: Color(0xFFDEDEDE),
                  thickness: 4,
                  indent: 20,
                  height: 80,
                  endIndent: 20,
                ),
                Expanded(child: Container()),

                //Review Button
                Obx(
                  () => InkWell(
                    onTap: () {
                      if (
                          //Check that both from and to have been selected
                          controller.selectedFromAccountType.value.isNotEmpty &&
                              controller
                                  .selectedToAccountType.value.isNotEmpty &&
                              //Check that a transfer amount more than 0 is entered
                              controller.transferAmount.value > 0
                          //&&
                          //Check if enough balance is available
                          //controller.availableBalanceInFromAccount >=
                          //controller.transferAmount.value
                          ) {
                        Get.to(() => TransferReview());
                      } else {
                        null;
                      }
                    },
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.only(
                        bottom: 180,
                      ),
                      decoration: BoxDecoration(
                        color: //Check that both from and to have been selected
                            controller.selectedFromAccountType.value
                                        .isNotEmpty &&
                                    controller.selectedToAccountType.value
                                        .isNotEmpty &&
                                    //Check that a transfer amount more than 0 is entered
                                    controller.transferAmount.value > 0
                                //&&
                                //Check if enough balance is available
                                //controller.availableBalanceInFromAccount >=
                                //controller.transferAmount.value
                                ? Color(0xFF152951)
                                : Color(0xFFBDBDBD),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Review",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "OpenSans",
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
