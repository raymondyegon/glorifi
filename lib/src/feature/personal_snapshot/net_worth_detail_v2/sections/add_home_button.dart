import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class AddHomeButton extends StatelessWidget {
  const AddHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // TODO: add home
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
            color: Color(0xFFF1F4FB),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(color: Color(0xFFB7C9EC))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 27,
                  color: GlorifiColors.midnightBlue,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'Add Home',
                style: TextStyle(color: GlorifiColors.midnightBlue),
              ),
              Spacer(),
              Icon(
                Icons.chevron_right,
                size: 27,
                color: GlorifiColors.midnightBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
