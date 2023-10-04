import 'package:flutter/material.dart';

class DefaultTeaser extends StatelessWidget {
  final int index;

  const DefaultTeaser({
    Key? key,
    required int this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 15,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        margin: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: MediaQuery.of(context).size.width * .8,
        height: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is not a teaser type we will use."),
          ],
        ),
      ),
    );
  }
}
