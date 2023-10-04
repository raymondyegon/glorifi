import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class FluidGridExample extends StatefulWidget {
  FluidGridExample({Key? key}) : super(key: key);

  @override
  State<FluidGridExample> createState() => _FluidGridExampleState();
}

class _FluidGridExampleState extends State<FluidGridExample> {
  late final List<AdaptiveGridItem> widgets;
  @override
  void initState() {
    widgets = [
      adaptiveGridItem(
        desktop: 100,
        tablet: 100,
      ),
      adaptiveGridItem(
        desktop: 50,
        tablet: 50,
      ),
      adaptiveGridItem(
        desktop: 50,
        tablet: 50,
      ),
      adaptiveGridItem(
        desktop: 33,
      ),
      adaptiveGridItem(
        desktop: 33,
      ),
      adaptiveGridItem(
        desktop: 33,
      ),
      adaptiveGridItem(
        tablet: 25,
      ),
      adaptiveGridItem(
        tablet: 25,
      ),
      adaptiveGridItem(
        tablet: 25,
      ),
      adaptiveGridItem(
        tablet: 25,
      ),
    ];
    super.initState();
  }

  AdaptiveGridItem adaptiveGridItem({
    double? desktop,
    double? tablet,
    double? nativeMobile,
    double? webMobile,
  }) {
    return AdaptiveGridItem(
      desktop: desktop,
      tablet: tablet,
      nativeMobile: nativeMobile,
      webMobile: webMobile,
      child: Container(
        height: 0.3.sh,
        color: GlorifiColors.darkBlue,
        child: Image.asset(
          'assets/images/flex_example.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveGrid(
        gridSpacing: 16,
        children: widgets,
      ),
    );
  }
}
