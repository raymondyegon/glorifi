import 'package:flutter/material.dart';

class CompareWithOthers extends StatelessWidget {
  const CompareWithOthers({
    Key? key,
    required this.text1,
    required this.paragraph,
    required this.onPressed,
  }) : super(key: key);

  final String text1;
  final String paragraph;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 26, right: 26, top: 26),
      height: 329,
      width: 352,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xfff3f2f2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$text1%',
            style: const TextStyle(
              color: Color(0xff767676),
              fontSize: 75,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            paragraph,
            style: const TextStyle(
              color: Color(0xff767676),
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => onPressed,
                style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  minimumSize: const Size(198, 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                  'Compare with Others',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
