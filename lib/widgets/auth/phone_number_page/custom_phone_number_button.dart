import 'package:app/constants.dart';
import 'package:app/utils/widget/custom_bottom.dart';
import 'package:flutter/material.dart';

class CustomPhoneNumberButton extends StatelessWidget {
  const CustomPhoneNumberButton(
      {super.key, required this.size, required this.onPressed});
  final Size size;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomBottom(
        text: 'Send the code',
        margin: EdgeInsets.symmetric(horizontal: size.width * .08),
        colorBottom: Colors.white,
        colorText: kPrimaryColor,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(8),
        width: size.width);
  }
}
