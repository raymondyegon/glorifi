import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class OpenCloseStatusWidget extends StatelessWidget {
  final bool? fullState;
  final int? openAccountCount;
  final int? closedAccountCount;

  const OpenCloseStatusWidget(
      {Key? key,
      this.fullState: false,
      this.openAccountCount: 0,
      this.closedAccountCount: 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opened',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 8.h,
        ),
        fullState == false
            ? IntrinsicHeight(
                child: Row(
                  children: [
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Text(
                      '$openAccountCount',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '$openAccountCount',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          'Closed',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 8.h,
        ),
        fullState == false
            ? IntrinsicHeight(
                child: Row(
                  children: [
                    VerticalDivider(
                      color: Colors.black87,
                      thickness: 1,
                    ),
                    Text(
                      '$closedAccountCount',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '$closedAccountCount',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
      ],
    );
  }
}

class AppString {
  static String generalContent =
      'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.';
}
