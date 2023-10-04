import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/credit_card/widgets/title_text_widget.dart';

class LinkCardTitleWidget extends StatelessWidget {
  const LinkCardTitleWidget({Key? key,required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleTextWidget(titleText: "Linked Credit Card"),
        InkWell(
          onTap: onTap,
          child: Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
