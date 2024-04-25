import 'package:app/widgets/auth/phone_number_page/custom_phone_number_button.dart';
import 'package:app/widgets/auth/phone_number_page/custom_phone_number_image.dart';
import 'package:app/widgets/auth/phone_number_page/custom_phone_number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PhoneNumberPageBody extends StatefulWidget {
  const PhoneNumberPageBody({super.key, required this.size});

  final Size size;

  @override
  State<PhoneNumberPageBody> createState() => _PhoneNumberPageBodyState();
}

class _PhoneNumberPageBodyState extends State<PhoneNumberPageBody> {
  TextEditingController controller = TextEditingController();
  String? phoneNumber;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.size.height * .2),
      child: SingleChildScrollView(
        child: Column(children: [
          CustomPhoneNumberImage(size: widget.size),
          CustomPhoneNumberTextField(
              size: widget.size,
              controller: controller,
              onChanged: (value) {
                setState(() {
                  phoneNumber = value.countryCode + value.number;
                });
              }),
          CustomPhoneNumberButton(
              size: widget.size,
              onPressed: () {
                print('phone number: $phoneNumber');
              })
        ]),
      ),
    );
  }
}
