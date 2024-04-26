import 'package:app/widgets/auth/opt_phone_number_page/custom_opt_phone_number_text.dart';
import 'package:flutter/material.dart';

class CustomOptResendCodetext extends StatelessWidget {
  const CustomOptResendCodetext({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CustomOptPhoneNumbertext(
          size: size,
          text: 'Didn\'t receive code? \n Resend',
          textColor: Colors.white54,
          textSize: size.height * .014),
    );
  }
}
