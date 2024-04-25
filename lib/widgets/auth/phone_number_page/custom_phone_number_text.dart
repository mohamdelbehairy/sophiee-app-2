import 'package:flutter/material.dart';

class CustomPhoneNumberText extends StatelessWidget {
  const CustomPhoneNumberText({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Phone Verification',
          style: TextStyle(fontSize: size.height * .035)),
      Text('We need to register your phone\n before getting started!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: size.height * .014))
    ]);
  }
}