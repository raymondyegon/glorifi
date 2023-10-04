import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class TryAgainWidget extends StatelessWidget {
  final Function()? onTap;

  const TryAgainWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool loading = false.obs;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                8.r,
              ),
              topRight: Radius.circular(
                8.r,
              ),
            ),
            color: GlorifiColors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  loading.value
                      ? Container(
                          width: 22.w,
                          height: 22.w,
                          child: GlorifiSpinner(
                            size: 16,
                          ),
                        ).paddingOnly(
                          right: 10.7.w,
                        )
                      : SvgPicture.asset(
                          GlorifiAssets.banking,
                          height: 24.h,
                          color: GlorifiColors.blueMidnightBlue,
                        ).paddingOnly(
                          right: 10.7.w,
                        ),
                  Text(
                    TextConstants.banking,
                    style: bodySemiBold18Primary(
                        color: GlorifiColors.blueMidnightBlue),
                  ),
                ],
              ).paddingSymmetric(
                horizontal: 18.w,
                vertical: 24.h,
              ),
              Divider(
                thickness: 1,
                color: GlorifiColors.altoGrey,
              ).paddingOnly(
                left: 8.w,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                8.r,
              ),
              bottomRight: Radius.circular(
                8.r,
              ),
            ),
            color: GlorifiColors.white.withOpacity(0.6),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 42.w,
            vertical: 33.h,
          ),
          child: Column(
            children: [
              Text(
                TextConstants.issueLoadingInformation,
                textAlign: TextAlign.center,
                style: bodyRegular18Primary(
                  color: GlorifiColors.blueMidnightBlue,
                ),
              ),
              SizedBox(
                height: 21.h,
              ),
              Obx(() {
                return Ripple(
                  onTap: loading.value
                      ? () {}
                      : () async {
                          try {
                            loading.value = true;
                            // setState(() {});
                            await onTap!();
                          } finally {
                            loading.value = false;
                            // setState(() {});
                          }
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        GlorifiAssets.refresh,
                        height: 20.h,
                        color: GlorifiColors.darkBlue,
                      ).paddingOnly(
                        right: 10.w,
                      ),
                      Text(
                        TextConstants.tryAgain,
                        style: bodyBold18Primary(
                          color: GlorifiColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
