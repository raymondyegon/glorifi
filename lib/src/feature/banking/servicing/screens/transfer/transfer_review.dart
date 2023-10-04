import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_success.dart';
import 'package:glorifi/src/widgets/buttons/custom_async_button.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:intl/intl.dart';

class TransferReview extends GetView<TransferController> {
  const TransferReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usCurrency = NumberFormat("#,##0.00", "en_US");

    convertAccountToLastFourDigitsGlorifi(fromOrTo) {
      if (fromOrTo == "from") {
        return controller.selectedGlorifiAccountFrom!.value!.accountNumber
            .substring(controller
                    .selectedGlorifiAccountFrom!.value!.accountNumber.length -
                4);
      } else {
        return controller.selectedGlorifiAccountTo!.value!.accountNumber
            .substring(controller
                    .selectedGlorifiAccountTo!.value!.accountNumber.length -
                4);
      }
    }
    // var rawGlorifiAccountNumber =
    //     controller.selectedGlorifiAccount!.value!.accountNumber;
    // var formattedGlorifiNumber =
    //     rawGlorifiAccountNumber.substring(rawGlorifiAccountNumber.length - 4);

    //Get Todays Date And Format
    final DateTime todaysDate = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    final String dateFormatted = formatter.format(todaysDate);

    Get.find<TransferController>();
    return Scaffold(
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
      body: Container(
        color: Color(0xFFE5E5E5),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: [
            Text(
              "You're Transferring",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 32,
                color: Color(0xFF131A3D),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 55,
                    color: Color(0xFF131A3D),
                  ),
                  Obx(
                    () => Text(
                      // ignore: use_raw_strings
                      usCurrency.format(controller.transferAmount.value),

                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                        color: Color(0xFF131A3D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xFFDEDEDE),
              thickness: 4,
              indent: 0,
              height: 80,
              endIndent: 0,
            ),
            //From Row
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "From",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 15,
                      color: Color(
                        0xFFA1A1A1,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        controller.selectedFromAccountType.value == "Glorifi"
                            ? controller
                                .selectedGlorifiAccountFrom!.value!.accountName
                            : controller.selectedLinkedAccountFrom!.value!.name,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 16,
                          color: Color(0xFF03213D),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                        ),
                      ),
                      Text(
                        controller.selectedFromAccountType.value == "Glorifi"
                            ? convertAccountToLastFourDigitsGlorifi("from")
                            : controller.selectedLinkedAccountFrom!.value!.mask,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 16,
                          color: Color(0xFF03213D),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            //To Row
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 15,
                      color: Color(
                        0xFFA1A1A1,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        controller.selectedToAccountType.value == "Glorifi"
                            ? controller
                                .selectedGlorifiAccountTo!.value!.accountName
                            : controller.selectedLinkedAccountTo!.value!.name,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 16,
                          color: Color(0xFF03213D),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                        ),
                      ),
                      Text(
                        controller.selectedToAccountType.value == "Glorifi"
                            ? convertAccountToLastFourDigitsGlorifi("to")
                            : controller.selectedLinkedAccountTo!.value!.mask,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 16,
                          color: Color(0xFF03213D),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            //Freuqency Row
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Frequency",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 15,
                      color: Color(
                        0xFFA1A1A1,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "One",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 16,
                          color: Color(0xFF03213D),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                        ),
                      ),
                      Text(
                        "Time",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 16,
                          color: Color(0xFF03213D),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //Date Row
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 15,
                      color: Color(
                        0xFFA1A1A1,
                      ),
                    ),
                  ),
                  Text(
                    dateFormatted,
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 16,
                      color: Color(0xFF03213D),
                    ),
                  ),
                ],
              ),
            ),
            //Expanded for Allowing Button to Stick To Bottom
            Expanded(
              child: Container(),
            ),
            //Review Button
            CustomAsyncButton(
              onTap: () async {
                await controller.submitTransfer();
              },
              loadingWidget: _loadingButton(),
              child: Container(
                height: 70,
                margin: const EdgeInsets.only(
                  bottom: 60,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF152951),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Transfer",
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
                    Text(
                      "\$${usCurrency.format(controller.transferAmount.value).toString()}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loadingButton() {
    return Container(
        height: 70,
        width: double.infinity,
        margin: const EdgeInsets.only(
          bottom: 60,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF152951),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
      
    );
  }
}
