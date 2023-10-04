import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/link_more_accounts_card/last_linked_account_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';

class LastLinkedAccountLogoWidget extends StatelessWidget {
  const LastLinkedAccountLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LastLinkedAccountController _lastAddedAccountDataController =
        Get.put(LastLinkedAccountController());

    return StatefulWrapper(
      onInit: () {
        _lastAddedAccountDataController.getLastAddedAccountInfo();
      },
      child: _lastAddedAccountDataController.obx(
        (state) {
          return _lastAddedAccountDataController.img == null ||
                  _lastAddedAccountDataController
                          .accountData.value.institutionLogo ==
                      ''
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: GlorifiColors.black.withOpacity(0.2),
                          blurRadius: 34,
                        ),
                      ],
                    ),
                    child: Image.memory(_lastAddedAccountDataController.img!),
                  ),
                );
        },
        onError: (_) {
          return Container();
        },
        onLoading: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  color: GlorifiColors.black.withOpacity(0.2),
                  blurRadius: 34,
                ),
              ],
            ),
            child: ShimmeryPlaceHolder(
              elevation: 0,
              margin: EdgeInsets.zero,
              radius: 48,
            ),
          ),
        ),
      ),
    );
  }
}
