import 'package:app/constants.dart';
import 'package:app/widgets/auth/phone_number_page/phone_number_page_body.dart';
import 'package:flutter/material.dart';

class PhoneNumberPage extends StatelessWidget {
  const PhoneNumberPage({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              const Color(0xff32d59a),
              const Color(0xff32cba0),
              const Color(0xff2fc2a8),
              kPrimaryColor
            ])),
        child: PhoneNumberPageBody(size: size),
      ),
    );
  }
}
