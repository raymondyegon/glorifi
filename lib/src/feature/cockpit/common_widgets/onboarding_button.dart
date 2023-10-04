/*import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class OnboardButton extends StatelessWidget {
  final btn_name;
  final Callback clback;

  const OnboardButton({Key? key, required this.btn_name, required this.clback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: clback,
      child: Text(btn_name),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10.0),
        primary: Colors.white,
        backgroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 18),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomWidgets {
  Widget onBoardButton(String btnName, Callback callback) {
    return TextButton(
      onPressed: callback,
      child: Text(btnName),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10.0),
        primary: Colors.white,
        backgroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget textField(TextEditingController controller,
      TextInputType textInputType, String helperText) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          helperText: helperText,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          focusColor: Colors.black),
    );
  }
}
