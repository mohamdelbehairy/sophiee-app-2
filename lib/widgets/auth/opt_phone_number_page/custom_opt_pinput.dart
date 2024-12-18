import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomOptPinput extends StatelessWidget {
  const CustomOptPinput(
      {super.key, required this.size, this.onCompleted});

  final Size size;

  final void Function(String)? onCompleted;


  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 50,
        height: 50,
        textStyle: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(30, 60, 87, 1),
            fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
            color: Colors.white54,
            borderRadius: BorderRadius.circular(16)));

    final focusedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration
            ?.copyWith(borderRadius: BorderRadius.circular(8)));

    final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration
            ?.copyWith(color: Color.fromRGBO(234, 239, 243, 1)));
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.width * .05, horizontal: size.width * .06),
        child: Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            onCompleted: onCompleted));
  }
}
