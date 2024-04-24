import 'package:app/constants.dart';
import 'package:app/widgets/auth/provider_auth_page/provider_auth_page_body_component.dart';
import 'package:flutter/material.dart';

class ProviderAuthPageBody extends StatelessWidget {
  const ProviderAuthPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        child: ProviderAuthPageBodyComponent(size: size));
  }
}
