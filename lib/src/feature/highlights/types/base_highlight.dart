import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/highlights/highlight_controller.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

final CARD_RADIUS = 15.0;

class BaseHighlight extends GetView<HighlightController> {
  final Widget child;
  final highlight;
  final Function? onTap;

  const BaseHighlight(
      {Key? key,
      this.onTap = null,
      required Widget this.child,
      required this.highlight})
      : super(
          key: key,
        );

  _openModel() {
    if (onTap != null) {
      onTap?.call();
    }

    if (highlight.isPlaid) {
      PlaidController plaidController = Get.put(PlaidController());

      plaidController.openPlaid();
      PlaidLink.onSuccess((error, metadata) {
        controller.updatePlaidCard();
      });
    } else if (highlight.route != null) {
      Get.toNamed(highlight.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _highlight() {
      if (highlight.imageUri == null) {
        return child;
      }
      return Stack(children: [_imageBackground(), Center(child: child)]);
    }

    return InkWell(
        onTap: _openModel,
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow),
                )
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(CARD_RADIUS)),
              child: _highlight(),
            )));
  }

  Container _imageBackground() {
    return Container(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(CARD_RADIUS),
      image: DecorationImage(
        image: AssetImage(highlight.imageUri),
        fit: BoxFit.fill,
      ),
    ));
  }
}
