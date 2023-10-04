import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/widgets/loader/loading.dart';

///Provides a container which shows a loading widget over the child
///[loadingControllers] this is a list of obs of [PageState], based on
///this [loadingControllers] this widget shows loading when the
///controller value is [PageState.LOADING]
///[child] child of the container
class LoadingContainer extends StatelessWidget {
  final List<Rx<PageState>> loadingControllers;
  final Widget child;

  const LoadingContainer(
      {Key? key, required this.child, required this.loadingControllers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _prepareChild(),
    );
  }

  List<Widget> _prepareChild() {
    List<Widget> children = [];
    children.add(child);

    children.addAll(loadingControllers
        .map((Rx<PageState> pageStateController) => Obx(() {
              Log.debug(pageStateController.value);
              return pageStateController.value == PageState.LOADING
                  ? Positioned.fill(
                      child: AbsorbPointer(
                      child: Loading(),
                    ))
                  : Container();
            }))
        .toList());

    return children;
  }
}
