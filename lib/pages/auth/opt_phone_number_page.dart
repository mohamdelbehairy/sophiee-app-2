import 'package:app/constants.dart';
import 'package:app/cubit/auth/phone_number_auth/phone_number_auth_cubit.dart';
import 'package:app/pages/create_account/add_user_data_page.dart';
import 'package:app/widgets/auth/opt_phone_number_page/opt_phone_number_page_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class OptPhoneNumberPage extends StatelessWidget {
  const OptPhoneNumberPage(
      {super.key, required this.size, required this.phoneNumber});
  final Size size;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    var verifyPhoneNumber = context.read<PhoneNumberAuthCubit>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<PhoneNumberAuthCubit, PhoneNumberAuthState>(
          listener: (context, state) async {
            if (state is VerifyPhoneNumberAuthSuccess) {
              print('لقد نجحنااااااااااااااااااااااااااا');
              print(
                  'isVerified: ${FirebaseAuth.instance.currentUser!.phoneNumber}');
              await Future.delayed(const Duration(seconds: 3));
              getnav.Get.to(() => AddUserDataPage(),
                  transition: getnav.Transition.rightToLeft);
            }
          },
          builder: (context, state) {
            return Container(
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
                child: OptPhoneNumberPageBody(
                    verifyPhoneNumber: verifyPhoneNumber,
                    size: size,
                    phoneNumber: phoneNumber));
          },
        ));
  }
}
