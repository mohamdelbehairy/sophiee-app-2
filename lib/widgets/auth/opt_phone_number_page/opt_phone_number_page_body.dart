import 'package:app/widgets/auth/opt_phone_number_page/custom_opt_phone_number_text.dart';
import 'package:app/widgets/auth/opt_phone_number_page/custom_opt_pinput.dart';
import 'package:app/widgets/auth/custom_phone_number_image.dart';
import 'package:app/widgets/auth/custom_phone_number_text.dart';
import 'package:app/widgets/auth/opt_phone_number_page/custom_opt_resend_code_text.dart';
import 'package:flutter/material.dart';

class OptPhoneNumberPageBody extends StatelessWidget {
  const OptPhoneNumberPageBody({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * .15),
      child: SingleChildScrollView(
        child: Column(children: [
          CustomPhoneNumberImage(size: size),
          CustomPhoneNumberText(
              firsttextSize: size.height * .03,
              firsttext: 'Verification Security Code',
              secondtext: 'Enter the code send to the number',
              size: size),
          SizedBox(height: size.width * .015),
          CustomOptPhoneNumbertext(
              size: size,
              text: '+20 1121050563',
              textColor: Colors.white54,
              textSize: size.height * .014),
          CustomOptPinput(size: size),
          CustomOptResendCodetext(size: size),
        ]),
      ),
    );
  }
}

