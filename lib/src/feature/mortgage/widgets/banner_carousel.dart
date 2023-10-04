import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/feature/mortgage/model/banner_data_model.dart';
import 'package:glorifi/src/feature/mortgage/widgets/build_page_indicator.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel(
      {Key? key,
      required this.currentPage,
      required this.onChange,
      required this.bannerData,
      this.onTap})
      : super(key: key);

  final currentPage;
  final Function(int) onChange;
  final List<Data> bannerData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CarouselSlider.builder(
            itemCount: bannerData.length,
            options: CarouselOptions(
                height: 400.h,
                viewportFraction: 1,
                onPageChanged: (i, r) {
                  onChange(i);
                }),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return InkWell(
                onTap: onTap,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        bannerData[itemIndex].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0xFF212C37).withOpacity(0.4),
                              Color(0xFF212C37).withOpacity(0.9),
                              Color(0xFF212C37),
                              Color(0xFF212C37),
                            ],
                            stops: [0.0, 0.6, 0.75, 0.8, 1],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 70,
                        left: 25,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bannerData[itemIndex].title,
                                style: TextStyle(
                                    fontFamily: 'univers',
                                    color: Colors.white,
                                    height: 1.3,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    bannerData[itemIndex].subtitle,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'univers',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/arrow.svg",
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 35,
          left: 25,
          child: Row(
            children: buildPageIndicator(
                currentPage: currentPage, totalPages: bannerData.length),
          ),
        )
      ],
    );
  }
}
