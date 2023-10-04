import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_breakpoints.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_screen_type.dart';

class AdaptiveGrid extends StatefulWidget {
  final List<AdaptiveGridItem> children;
  final double? gridSpacing;

  const AdaptiveGrid(
      {Key? key, this.children = const <AdaptiveGridItem>[], this.gridSpacing})
      : super(key: key);

  @override
  _AdaptiveGridState createState() => _AdaptiveGridState();
}

//  AdaptiveGrid
class _AdaptiveGridState extends State<AdaptiveGrid> {
  @override
  Widget build(BuildContext context) {
    // Get Halpspacing
    final halfSpacing = (widget.gridSpacing ?? 0) / 2;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: halfSpacing,
      ),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final mediaQueryData = MediaQuery.of(context);
        final breakpoint = getDeviceType(mediaQueryData);
        double spanWidth = constraints.maxWidth;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _getDistributedWidgetList(widget.children, breakpoint)
                .map((list) {
              var totalFlex = 0.0;
              list.forEach((e) => totalFlex += e.getWidthSpan(breakpoint));
              totalFlex = totalFlex.reduced;
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: []
                    ..addAll(list.map((e) {
                      return Container(
                        padding: EdgeInsets.all(halfSpacing),
                        child: e,
                        width: e.getWidthSpan(breakpoint) * spanWidth / 100,
                      );
                    }))
                    ..add(Container(
                      width: (100 - totalFlex) * spanWidth / 100,
                    )),
                ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}

class AdaptiveGridItem extends StatefulWidget {
  final double? webMobile;
  final double? tablet;
  final double? desktop;
  final double? nativeMobile;
  final Widget? child;

  const AdaptiveGridItem({
    Key? key,
    this.child,
    this.webMobile,
    this.tablet,
    this.desktop,
    this.nativeMobile,
  }) : super(key: key);

  double getWidthSpan(AdaptiveScreenType _breakPoint) {
    switch (_breakPoint) {
      case AdaptiveScreenType.webMobile:
        return (webMobile ?? 100).reduced;
      case AdaptiveScreenType.nativeMobile:
        return (nativeMobile ?? 100).reduced;
      case AdaptiveScreenType.tablet:
        return (tablet ?? 33.32).reduced;
      case AdaptiveScreenType.desktop:
        return (desktop ?? 25).reduced;
    }
  }

  @override
  _AdaptiveGridItemState createState() => _AdaptiveGridItemState();
}

extension _DoubleExtension on double {
  double get reduced {
    return this > 100 ? 100 : this;
  }
}

class _AdaptiveGridItemState extends State<AdaptiveGridItem> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? SizedBox();
  }
}

List<List<AdaptiveGridItem>> _getDistributedWidgetList(
    List<AdaptiveGridItem> items, AdaptiveScreenType _breakPoint) {
  var tempTotalFlex = 0.0;
  List<List<AdaptiveGridItem>> finalList = [];
  List<AdaptiveGridItem> itemList = [];

  for (var item in items) {
    tempTotalFlex += item.getWidthSpan(_breakPoint);
    if (tempTotalFlex.roundToDouble() <= 100) {
      itemList.add(item);
    } else {
      finalList.add(itemList);
      tempTotalFlex = item.getWidthSpan(_breakPoint);
      itemList = []..add(item);
    }
  }
  finalList.add(itemList);
  return finalList;
}
