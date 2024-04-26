import 'package:app/constants.dart';
import 'package:app/utils/widget/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OptPhoneNumberPage extends StatelessWidget {
  const OptPhoneNumberPage({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .06),
        child: Column(children: [
          Text('Verification\n Security Code',
              style: TextStyle(color: Colors.black, fontSize: 45)),
          SizedBox(height: size.height * .2),
          Pinput(length: 6),
          TextButton(
              onPressed: () {},
              child: Text('Didn\'t Get Code? Resend',
                  style: TextStyle(color: kPrimaryColor))),
          CustomBottom(
              text: 'Verify phone number',
              colorBottom: kPrimaryColor,
              colorText: Colors.white,
              onPressed: () {},
              borderRadius: BorderRadius.circular(32),
              width: size.width)
        ]),
      ),
    );
  }
}
