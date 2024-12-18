import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/utils/widget/show_top_snack_bar/show_top_snack_bar_failure.dart';
import 'package:app/widgets/login_page/login_page_botom_sheet_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageBottomSheet extends StatelessWidget {
  const LoginPageBottomSheet({super.key, required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.75,
      maxChildSize: 0.88,
      builder: (context, controller) => SingleChildScrollView(
        reverse: true,
        child: Container(
          decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure &&
                  state.errorMessage == 'invalid-credential') {
                showTopSnackBarFailure(
                    context: context,
                    maxLines: 3,
                    message:
                        "Opps, There was a problem logging in. Check your email and password or create an account.");
              } else if (state is LoginSuccess &&
                  FirebaseAuth.instance.currentUser!.emailVerified) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(width: 50, child: Divider(thickness: 5)),
                  LoginPageBottomSheetBody(isDark: isDark),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
