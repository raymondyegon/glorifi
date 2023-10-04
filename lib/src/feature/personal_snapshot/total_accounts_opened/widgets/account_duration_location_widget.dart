import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class AccountDurationAndLocationWidget extends StatelessWidget {
  final String duration;
  final String location;

  const AccountDurationAndLocationWidget({
    Key? key,
    this.duration: 'As of 10 Mar',
    this.location: 'Dallas, TX, USA',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          duration,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          child: Center(
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Text(
          location,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
