import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_review_application_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../../../utils/glorifi_assets.dart';

// Step 3 of 6
// https://app.asana.com/0/1202239119682092/1202240186732671/f

class OAOVerifyCitizenshipScreen2 extends StatefulWidget {
  OAOVerifyCitizenshipScreen2({Key? key}) : super(key: key);

  @override
  State<OAOVerifyCitizenshipScreen2> createState() =>
      _OAOVerifyCitizenshipScreen2State();
}

class _OAOVerifyCitizenshipScreen2State
    extends State<OAOVerifyCitizenshipScreen2> {
  OAOController controller = Get.find();
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
      info: OAOScreensInfo.OAOVerifyCitizenshipScreen2,
      children: _content(context),
      onContinue: () async {
        if (controller.application.nonUSCitizenship.length == 0) {
          setState(() {
            error = true;
          });
        } else {
          await controller.onConfirmCitizenship();
        }
      },
    );
  }

  List<Widget> _content(BuildContext context) {
    return [
      ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(1.sw, 64.h)),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          elevation: MaterialStateProperty.all<double>(0),
          shadowColor: MaterialStateProperty.all<Color>(GlorifiColors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(GlorifiColors.white),
        ),
        onPressed: () {
          showCountryPicker(
            context: context,
            showWorldWide: false,
            countryListTheme: CountryListThemeData(
              flagSize: 25,
              backgroundColor: Colors.white,
              // textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
              bottomSheetHeight: 500.h,
              // Optional. Country list modal height
              // Optional. Sets the border radius for the bottom sheet.
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              //Optional. Styles the search field.
              inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Start typing to search',
                labelStyle: TextStyle(color: GlorifiColors.silver),
                prefixIcon: const Icon(
                  Icons.search,
                  color: GlorifiColors.silver,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: GlorifiColors.silver.withOpacity(0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: GlorifiColors.silver,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            onSelect: (Country country) {
              if (!controller.application.nonUSCitizenship
                  .contains(country.name)) {
                controller.application.nonUSCitizenship.add(country.name);
              }
              setState(() {
                error = false;
              });
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            border: Border.all(color: GlorifiColors.silver.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10.r),
          ),
          width: 1.sw,
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  "Country",
                  style: smallRegular16Primary(
                    color: GlorifiColors.midnightBlue,
                  ),
                ),
              ),
              Align(
                child: SvgPicture.asset(
                  GlorifiAssets.chevronDown,
                  color: GlorifiColors.midnightBlue,
                ),
              ).paddingOnly(right: 5.w),
            ],
          ),
        ),
      ),
      Obx(
        () => ListView.builder(
          itemCount: controller.application.nonUSCitizenship.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 24.h),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.zero,
              //padding: EdgeInsets.only(bottom: 24.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.application.nonUSCitizenship[index]),
                  InkWell(
                    child: Text("x"),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  "Remove ${controller.application.nonUSCitizenship[index]}"),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Cancel",
                                    style:
                                        TextStyle(color: GlorifiColors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "Continue",
                                    style:
                                        TextStyle(color: GlorifiColors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    controller.application.nonUSCitizenship
                                        .remove(controller.application
                                            .nonUSCitizenship[index]);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  )
                ],
              ).paddingOnly(bottom: 24.h),
            );
          },
        ),
      ),
      if (error)
        Text(
          "Please select a country",
          style: TextStyle(color: GlorifiColors.redError),
        ).paddingOnly(bottom: 30.h, left: 10.w),
    ];
  }
}
