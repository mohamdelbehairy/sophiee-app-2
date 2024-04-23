import 'package:app/constants.dart';
import 'package:app/widgets/auth/provider_auth_page/continue_with_email.dart';
import 'package:app/widgets/auth/provider_auth_page/custom_provider_way.dart';
import 'package:app/widgets/auth/provider_auth_page/custom_text.dart';
import 'package:app/widgets/auth/provider_auth_page/provider_divider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProviderAuthPageBodyComponent extends StatelessWidget {
  const ProviderAuthPageBodyComponent({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * .1),
      child: Column(
        children: [
          Image.asset(providerAuthPageImage, fit: BoxFit.cover),
          ProviderAuthPageCustomtext(size: size),
          CustomProviderWay(
              size: size,
              top: size.width * .05,
              text: 'Continue with Facebook',
              onTap: () {},
              widget: Icon(FontAwesomeIcons.facebook, color: Colors.blue)),
          CustomProviderWay(
              size: size,
              top: size.width * .03,
              text: 'Continue with Google',
              onTap: () {},
              widget: Image.asset(googleIcon, width: size.height * .03)),
          CustomProviderWay(
              size: size,
              top: size.width * .03,
              text: 'Continue with Phone',
              onTap: () {},
              widget: Icon(Icons.phone, color: Colors.teal.shade700)),
          SizedBox(height: size.width * .06),
          ProviderDivider(size: size),
          ContinueWithEmail(size: size)
        ],
      ),
    );
  }
}

