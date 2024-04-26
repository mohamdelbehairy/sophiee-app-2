import 'package:app/constants.dart';
import 'package:app/widgets/auth/opt_phone_number_page/opt_phone_number_page_body.dart';
import 'package:flutter/material.dart';

class OptPhoneNumberPage extends StatelessWidget {
  const OptPhoneNumberPage({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
            child: OptPhoneNumberPageBody(size: size)));
  }
}
