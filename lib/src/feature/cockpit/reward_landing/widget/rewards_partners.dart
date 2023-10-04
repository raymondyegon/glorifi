import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:get/get.dart';

class RewardsPartners extends StatelessWidget {
  const RewardsPartners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Use Reward Points With The Travel Brands You Love.",
          style: leadRegular24Secondary(color: GlorifiColors.darkBlue),
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: 214,
              viewportFraction: 1,
              autoPlayAnimationDuration: Duration(milliseconds: 1600),
              autoPlayInterval: Duration(seconds: 1),
              autoPlay: true),
          items: [0, 1, 2, 3].map((i) {
            return Builder(
              builder: (BuildContext context) {
                if (!(sizingInfo.isNativeMobile || sizingInfo.isWebMobile)) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [1, 2, 3, 4, 5, 6].map((subi) {
                        return Align(
                          child: Container(
                              width: 77,
                              height: 77,
                              child: Image.asset(
                                'assets/company_logo/company_logo' +
                                    (i * 6 + subi > 21
                                            ? (i * 6 + subi - 21)
                                            : (i * 6 + subi))
                                        .toString() +
                                    '.png',
                                fit: BoxFit.fill,
                                errorBuilder: (_, q, p) {
                                  return Container();
                                },
                              )).paddingAll(30),
                        );
                      }).toList());
                } else {
                  return GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      primary: true,
                      children: [1, 2, 3, 4, 5, 6].map((subi) {
                        return Align(
                          child: Container(
                              width: 77,
                              height: 77,
                              child: Image.asset(
                                'assets/company_logo/company_logo' +
                                    (i * 6 + subi > 21
                                            ? (i * 6 + subi - 21)
                                            : (i * 6 + subi))
                                        .toString() +
                                    '.png',
                                fit: BoxFit.fill,
                                errorBuilder: (_, q, p) {
                                  return Container();
                                },
                              )),
                        );
                      }).toList());
                }
              },
            );
          }).toList(),
        ).paddingOnly(top: 30, bottom: 30),
      ]).paddingOnly(left: 24, right: 24, top: 46, bottom: 36);
    });
  }
}
