import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/pages/create_account/verificaton_page.dart';
import 'package:app/utils/widget/show_top_snack_bar/show_top_snack_bar_failure.dart';
import 'package:app/utils/widget/custom_bottom.dart';
import 'package:app/utils/widget/auth/auth_bottom_sheet_top_text.dart';
import 'package:app/widgets/login_page/custom_forget_password.dart';
import 'package:app/utils/widget/auth/text_field_email.dart';
import 'package:app/utils/widget/auth/text_field_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class LoginPageBottomSheetBody extends StatefulWidget {
  const LoginPageBottomSheetBody({super.key, required this.isDark});
  final bool isDark;
  @override
  State<LoginPageBottomSheetBody> createState() =>
      _LoginPageBottomSheetBodyState();
}

class _LoginPageBottomSheetBodyState extends State<LoginPageBottomSheetBody> {
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var login = (context).read<LoginCubit>();
    // final isDark = context.read<LoginCubit>().isDark;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(right: 32, left: 32),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthBottomSheetTopText(isDark: widget.isDark, text: 'Get Login'),
              const SizedBox(height: 16),
              TextFieldEmail(emailAddress: emailAddress),
              const SizedBox(height: 8),
              TextFieldPassword(password: password),
              const SizedBox(height: 22),
              CustomBottom(
                width: double.infinity,
                borderRadius: BorderRadius.circular(32),
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        globalKey.currentState!.save();
                        await login.login(
                            context: context,
                            emailAddress: emailAddress.text,
                            password: password.text);
                        if (login.state is LoginSuccess &&
                            FirebaseAuth.instance.currentUser!.emailVerified) {
                          emailAddress.clear();
                          password.clear();
                        } else {
                          showTopSnackBarFailure(
                              context: context,
                              maxLines: 3,
                              onTap: () {
                                getnav.Get.to(
                                    () =>
                                        VerificationPage(isDark: widget.isDark),
                                    transition: getnav.Transition.leftToRight);
                              },
                              message:
                                  "Please verified you email and login again.");
                        }
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  isLoading: isLoading,
                  colorText: Colors.white,
                  colorBottom: kPrimaryColor,
                  text: 'Get Login'),
              CustomForgetPassword(emailAddress: emailAddress),
            ],
          ),
        ),
      ),
    );
  }
}
