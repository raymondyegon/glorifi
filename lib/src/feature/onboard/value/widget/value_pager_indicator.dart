import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/value/widget/indicator_dot.dart';

class ValuePagerIndicator extends StatelessWidget {
  final int pageCount;
  final int currentIndex;
  final bool center;

  const ValuePagerIndicator({
    Key? key,
    required this.pageCount,
    required this.currentIndex,
    this.center = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: _indicators(),
    );
  }

  List<IndicatorDot> _indicators() {
    final List<IndicatorDot> indicators = [];

    for (int i = 0; i < pageCount; i++) {
      indicators.add(
        IndicatorDot(isActive: i == currentIndex),
      );
    }

    return indicators;
  }
}
