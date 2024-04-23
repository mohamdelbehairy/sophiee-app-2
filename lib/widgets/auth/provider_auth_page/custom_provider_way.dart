import 'package:flutter/material.dart';

class CustomProviderWay extends StatelessWidget {
  const CustomProviderWay(
      {super.key,
      required this.size,
      required this.onTap,
      required this.widget,
      required this.text,
      required this.top});

  final Size size;
  final Function() onTap;
  final Widget widget;
  final String text;
  final double top;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * .06,
        margin: EdgeInsets.only(
            right: size.width * .08, left: size.width * .08, top: top),
        decoration: BoxDecoration(
            // color: Colors.white,
            border: Border.all(color: Colors.white.withOpacity(.3)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
            SizedBox(width: size.width * .015),
            Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height * .018,
                    fontWeight: FontWeight.w100))
          ],
        ),
      ),
    );
  }
}
