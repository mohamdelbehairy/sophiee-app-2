import 'package:app/cubit/auth/phone_number_auth/phone_number_auth_cubit.dart';
import 'package:app/widgets/auth/opt_phone_number_page/custom_opt_phone_number_text.dart';
import 'package:app/widgets/auth/opt_phone_number_page/custom_opt_pinput.dart';
import 'package:app/widgets/auth/custom_phone_number_image.dart';
import 'package:app/widgets/auth/custom_phone_number_text.dart';
import 'package:app/widgets/auth/opt_phone_number_page/custom_opt_resend_code_text.dart';
import 'package:app/widgets/verification_page/verification_page_progress_indicator.dart';
import 'package:flutter/material.dart';

class OptPhoneNumberPageBody extends StatefulWidget {
  const OptPhoneNumberPageBody(
      {super.key,
      required this.size,
      required this.phoneNumber,
      required this.verifyPhoneNumber,
      required this.resendPhoneNumber});

  final Size size;
  final String phoneNumber;
  final String resendPhoneNumber;
  final PhoneNumberAuthCubit verifyPhoneNumber;

  @override
  State<OptPhoneNumberPageBody> createState() => _OptPhoneNumberPageBodyState();
}

class _OptPhoneNumberPageBodyState extends State<OptPhoneNumberPageBody> {
  bool isLoading = false;

  void isLoadingMethod() async {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.size.height * .15),
      child: SingleChildScrollView(
        child: Column(children: [
          CustomPhoneNumberImage(size: widget.size),
          CustomPhoneNumberText(
              firsttextSize: widget.size.height * .03,
              firsttext: 'Verification Security Code',
              secondtext: 'Enter the code send to the number',
              size: widget.size),
          SizedBox(height: widget.size.width * .015),
          CustomOptPhoneNumbertext(
              size: widget.size,
              text: widget.phoneNumber,
              textColor: Colors.white54,
              textSize: widget.size.height * .014),
          CustomOptPinput(
            onCompleted: (value) async {
              await widget.verifyPhoneNumber.verifyPhoneNumber(smsCode: value);
              setState(() {
                isLoading = true;
              });
              await Future.delayed(const Duration(seconds: 3));
              setState(() {
                isLoading = false;
              });
            },
            size: widget.size,
          ),
          if (!isLoading)
            CustomOptResendCodetext(
                size: widget.size,
                resendCode: widget.verifyPhoneNumber,
                resendPhoneNumber: widget.resendPhoneNumber),
          if (isLoading) VerificationPageProgressIndicator(isDark: true),
        ]),
      ),
    );
  }
}
