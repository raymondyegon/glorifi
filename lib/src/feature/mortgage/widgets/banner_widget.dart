import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {Key? key, required this.title, required this.subtitle, this.onTap})
      : super(key: key);

  final title, subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.dstIn,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/sample_house.png")),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Colors.red, Colors.blue],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'univers',
                    height: 1.5,
                    fontWeight: FontWeight.normal,
                    fontSize: 40),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/arrow.svg",
                    height: 10,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
