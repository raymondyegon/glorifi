import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/card.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    this.title1 = '',
    this.text1 = '',
    this.title2 = '',
    this.text2 = '',
    this.paragraph = '',
    this.onPressed,
    required this.data,
  }) : super(key: key);

  final String title1;
  final String text1;
  final String title2;
  final String text2;
  final String paragraph;
  final Function? onPressed;
  final Widget data;

  @override
  Widget build(BuildContext context) {
    const titleStyled = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    const textStyled = TextStyle(
      color: Color(0xff767676),
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
    return GlorifiCard(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    title1,
                    style: titleStyled,
                  ),
                  Text(
                    text1,
                    style: textStyled,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    title2,
                    style: titleStyled,
                  ),
                  Text(
                    text2,
                    style: textStyled,
                  ),
                ],
              ),
            ],
          ),
          data,
          Text(
            paragraph,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed != null
              ? Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () => onPressed,
                      style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        minimumSize: const Size(136, 40),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        backgroundColor: const Color(0xff767676),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: Colors.transparent,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: const Text(
                        'Activate Data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 40),
        ],
      )
    );
  }
}
