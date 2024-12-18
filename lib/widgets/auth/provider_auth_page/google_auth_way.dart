import 'package:app/constants.dart';
import 'package:app/cubit/auth/google_auth/google_auth_cubit.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/widgets/auth/provider_auth_page/custom_provider_way.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class GoogleAuthWay extends StatelessWidget {
  const GoogleAuthWay({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    var signInWithGoogle = context.read<GoogleAuthCubit>();
    return BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
      listener: (context, state) async {
        if (state is GoogleAuthSuccess) {
          signInWithGoogle.isLoading = state.isLoading;
          await Future.delayed(const Duration(seconds: 3));

          getnav.Get.to(() => HomePage(),
              transition: getnav.Transition.rightToLeft);
        }
      },
      builder: (context, state) {
        return CustomProviderWay(
            isLoading: signInWithGoogle.isLoading,
            size: size,
            top: size.width * .03,
            text: 'Continue with Google',
            onTap: () async {
              final signInWithGoogle = context.read<GoogleAuthCubit>();
              await signInWithGoogle.signInWithGoogle();
            },
            widget: Image.asset(googleIconUrl, width: size.height * .035));
      },
    );
  }
}
