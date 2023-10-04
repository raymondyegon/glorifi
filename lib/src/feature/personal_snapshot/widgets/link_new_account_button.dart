import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class LinkNewAccountButton extends GetView<PlaidController> {
  const LinkNewAccountButton({
    this.onTap,
    Key? key,
  }) : super(key: key);

  final onTap;

  @override
  Widget build(BuildContext context) {
    Get.put(PlaidController());
    return Obx(
      () => InkWell(
        onTap: () async {
          try {
            controller.isLoading.value = true;

            await controller.openPlaid();
          } finally {
            controller.isLoading.value = false;
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          decoration: BoxDecoration(
              color: Color(0xFFF1F4FB),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(color: Color(0xFFB7C9EC))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: SvgPicture.asset(
                    GlorifiAssets.link,
                    color: GlorifiColors.midnightBlue,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Link New Account',
                  style:
                      captionBold14Primary(color: GlorifiColors.midnightBlue),
                ),
                Spacer(),
                controller.isLoading.value == true
                    ? CircularProgressIndicator()
                    : Icon(
                        Icons.chevron_right,
                        size: 27,
                        color: GlorifiColors.midnightBlue,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
