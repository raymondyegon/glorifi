import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/snapshot_carousel.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class PersonalSnapshotSection extends StatelessWidget {
  const PersonalSnapshotSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _mobile = Column(
      children: [
        SnapshotCarousel(),
        PersonalSnapshot(),
      ],
    );

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      Widget _web = Column(
      children: [
        SnapshotCarousel(),
        PersonalSnapshot(),
      ],
    );

      if (sizingInfo.isNativeMobile || sizingInfo.isWebMobile) {
        return _mobile;
      } else {
        return _web;
      }
    });
  }
}
