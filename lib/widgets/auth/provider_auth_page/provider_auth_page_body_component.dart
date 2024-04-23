import 'package:app/constants.dart';
import 'package:app/widgets/auth/provider_auth_page/custom_divider.dart';
import 'package:app/widgets/auth/provider_auth_page/custom_provider_way.dart';
import 'package:app/widgets/auth/provider_auth_page/custom_text.dart';
import 'package:flutter/material.dart';

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
          Row(
            children: [
              ProviderAuthPageCustomDivider(
                  size: size, left: size.width * .095, right: size.width * .03),
              Text('or'),
              ProviderAuthPageCustomDivider(
                  size: size, left: size.width * .03, right: size.width * .08),
            ],
          )
        ],
      ),
    );
  }
}
