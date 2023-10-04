import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../font_style_global.dart';

class BrokerageSignUp extends StatelessWidget {
  BrokerageSignUp({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/brokerage_bg.png",
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
                left: 20.w,
                top: 30.h,
                child: InkWell(
                  onTap: Get.back,
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 75.h),
                      padding: EdgeInsets.all(15),
                      child:
                          SvgPicture.asset("assets/images/brokerage_logo.svg"),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 20.h),
                      child: Text(
                        "Allocate funds through Stocks, Mutual Funds and ETF’s",
                        textAlign: TextAlign.center,
                        style: headlineRegular31Secondary(
                          color: GlorifiColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter an Email Address",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Sign Up!\n",
                            style: headlineBold31Secondary(
                              color: GlorifiColors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Coming soon: Glorifi Brokerage.",
                                style: smallRegular16Primary(
                                  color: GlorifiColors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "We're working really hard to bring Glorifi Members the ability to trade ETFs, Mutual Funds, Stocks and more.",
                                style: smallRegular16Primary(
                                  color: GlorifiColors.white,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                        width: 358.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Email Me",
                          style: bodyBold18Primary(
                            color: GlorifiColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        constraints: BoxConstraints.expand(),
      ),
    );
  }
}
