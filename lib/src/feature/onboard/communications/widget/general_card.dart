import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/communications/controllers/communications_controller.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import '../../../../font_style_global.dart';

class GeneralCard extends StatelessWidget {
  final CommunicationsController controller;
  const GeneralCard(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text('GENERAL', style: _getTitleStyle()),
                  const SizedBox(height: 12),
                  Text('GloriFi Messages', style: _getSubtitleTextStyle()),
                  const SizedBox(height: 6),
                  Text(
                    'Relating to service and terms',
                    style: _getDescriptionTextStyle(),
                  ),
                  const SizedBox(height: 36),
                ],
              ),
              Obx(
                () => Transform.scale(
                  scale: .8,
                  child: CupertinoSwitch(
                    value: controller.glorifiMessageStatus,
                    activeColor: GlorifiColors.darkBlue,
                    onChanged: (isChecked) {
                      controller.toggleGlorifiMessage();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _getTitleStyle() => captionBold14Primary(
        color: GlorifiColors.darkBlue,
      );

  TextStyle _getSubtitleTextStyle() => smallRegular16Primary(
        color: GlorifiColors.darkBlue,
      );

  TextStyle _getDescriptionTextStyle() => captionRegular14Primary(
        color: GlorifiColors.darkBlue,
      );
}
