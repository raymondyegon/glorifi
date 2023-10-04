import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TwoLineListTile extends StatelessWidget {
  const TwoLineListTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.trailingText = 'Link',
      this.onTap})
      : super(key: key);

  final String title;
  final String subtitle;
  final String trailingText;
  final void Function()? onTap;

  // ignore: todo
  //TODO apply glorifi ui kit
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.only(left: 24, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 55,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff212C37),
                        height: 1.33,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff212C37),
                        height: 1.375,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              if (onTap != null)
                Row(
                  children: [
                    Text(
                      trailingText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff212C37),
                      ),
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/arrow_right.svg',
                      color: Color(0xff212C37),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
