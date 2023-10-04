import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_logos.dart';

class GloriFiLogos extends StatelessWidget {
  const GloriFiLogos(
      {Key? key,
      required this.imageKey,
      required this.height,
      required this.width})
      : super(key: key);

  final String imageKey;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      GlorifiLogos.gloriFiLogos[imageKey]!,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
