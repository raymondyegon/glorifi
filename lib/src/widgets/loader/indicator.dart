import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class GlorifiIndicator extends StatefulWidget {
  final Widget child;
  final Function onRefresh;

  const GlorifiIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  _GlorifiIndicatorState createState() => _GlorifiIndicatorState();
}

class _GlorifiIndicatorState extends State<GlorifiIndicator>
    with SingleTickerProviderStateMixin {
  static const _indicatorSize = 120.0;

  /// Whether to render check mark instead of spinner
  bool _renderCompleteState = false;

  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: _indicatorSize,
      onRefresh: () => widget.onRefresh(),
      child: widget.child,
      completeStateDuration: const Duration(seconds: 0),
      onStateChanged: (change) {
        /// set [_renderCompleteState] to true when controller.state become completed
        // if (change.didChange(to: IndicatorState.complete)) {
        //   setState(() {
        //     _renderCompleteState = true;
        //   });

        //   /// set [_renderCompleteState] to false when controller.state become idle
        // } else if (change.didChange(to: IndicatorState.idle)) {
        //   setState(() {
        //     _renderCompleteState = false;
        //   });
        // }
      },
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? _) {
                if (controller.scrollingDirection == ScrollDirection.reverse &&
                    prevScrollDirection == ScrollDirection.forward) {
                   controller.stopDrag();
                }

                prevScrollDirection = controller.scrollingDirection;

                final containerHeight = controller.value * _indicatorSize;

                return Container(
                  padding: MediaQuery.of(context).padding,
                  color: Colors.white,
                  alignment: Alignment.center,
                  height: containerHeight,
                  child: OverflowBox(
                    maxHeight: 40,
                    minHeight: 40,
                    maxWidth: 40,
                    minWidth: 40,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      alignment: Alignment.center,
                      child: _renderCompleteState
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : SizedBox(
                              height: 30,
                              width: 30,
                              child: GlorifiSpinner(),
                            ),
                      decoration: BoxDecoration(
                        color: _renderCompleteState
                            ? GlorifiColors.darkBlue
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * _indicatorSize),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
    );
  }
}
