import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/bundles/controller/bundle_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BundleStory extends StatelessWidget {
  final BundleModel bundleModel;

  const BundleStory({Key? key, required this.bundleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _option(int index) {
      return Row(children: [
        Image.asset("assets/images/Checks.png"
            //  Icons.check,
            ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          bundleModel.options[index],
          style: TextStyle(color: Colors.white),
        )
      ]);
    }

    Widget _optionRow(int index1, index2) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _option(index1),
        SizedBox(
          width: 10.w,
        ),
        _option(index2)
      ]).paddingSymmetric(horizontal: 20.w);
    }

    Widget _options1() {
      if (bundleModel.options.length < 2) {
        return SizedBox.shrink();
      }
      return _optionRow(0, 1);
    }

    Widget _options2() {
      if (bundleModel.options.length < 3) {
        return SizedBox.shrink();
      }
      if (bundleModel.options.length == 3) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_option(2)]);
      }
      return _optionRow(2, 3);
    }

    return BaseStory(
        child: Stack(children: [
      Container(
          height: 0.5.sh,
          child: Image.asset(
            bundleModel.image,
            fit: BoxFit.fitHeight,
            width: double.infinity,
          )),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 1.sh,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.transparent,
                  GlorifiColors.blueMidnightBlue,
                  GlorifiColors.blueMidnightBlue,
                ],
                    stops: [
                  0.1,
                  0.4,
                  0.9
                ])),
          )),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
              child: Text(
            bundleModel.title + "\nBundle",
            textAlign: TextAlign.center,
            style: TextStyle(
                wordSpacing: 0.8,
                color: Colors.white,
                fontFamily: 'univers',
                fontSize: 44,
                fontWeight: FontWeight.w400),
          )),
          SizedBox(
            height: 10.h,
            width: 1.sw,
          ),
          Text("Maximum Savings",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              )),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 69.w,
                  child: Divider(
                    color: GlorifiColors.white,
                    height: 1.0,
                  )),
              Icon(
                Icons.star,
                color: GlorifiColors.darkOrange,
              ),
              SizedBox(
                  width: 69.w,
                  child: Divider(
                    color: GlorifiColors.white,
                    height: 1.0,
                  ))
            ],
          ),
          Text(
              "Apply for your mortgage\nwith ${bundleModel.title} Package and get:",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.4,
                fontSize: 14,
                color: Colors.white,
              )),
          SizedBox(
            height: 30.h,
          ),
          _options1(),
          SizedBox(
            height: 20.h,
          ),
          _options2(),
          SizedBox(
            height: 60.h,
          ),
          ElevatedButton.icon(
              style: ButtonStyle(
                fixedSize:
                    MaterialStateProperty.all<Size>(Size(1.sw - 30.h, 64.h)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(GlorifiColors.white),
              ),
              onPressed: () => Get.toNamed(bundleModel.route, arguments: {
                    BundleController.bundleTypeKey: bundleModel.bundleType
                  }),
              icon: Text(
                "Learn More",
                style: TextStyle(
                    fontSize: 18,
                    color: GlorifiColors.midnightBlue,
                    fontWeight: FontWeight.bold),
              ),
              label: Icon(
                Icons.arrow_forward,
                color: GlorifiColors.lightBlue,
              )),
          SizedBox(
            height: 28.h,
          )
        ],
      ),
    ]));
  }
}
