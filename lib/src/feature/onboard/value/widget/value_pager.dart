import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:glorifi/src/feature/onboard/value/model/value_content.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_text_content.dart';

class ValuePager extends StatefulWidget {
  final List<ValueContent> contents;
  final Function(int page)? onPageChange;

  const ValuePager({
    Key? key,
    required this.contents,
    this.onPageChange,
  }) : super(key: key);

  @override
  _ValuePagerState createState() => _ValuePagerState();
}

class _ValuePagerState extends State<ValuePager> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0,);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      allowImplicitScrolling: true,
      controller: pageController,
      onPageChanged: (page) => widget.onPageChange?.call(page),
      physics: CustomPageViewScrollPhysics(),
      itemCount: widget.contents.length,
      itemBuilder: (context, index) => ValueContentWidget(
        key: PageStorageKey<String>(widget.contents[index].title),
        valueContent: widget.contents[index],
      )
    );
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 55,
    stiffness: 80,
    damping: 0.9,
  );
}



