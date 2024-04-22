import 'package:app/constants.dart';
import 'package:app/utils/widget/custom_bottom.dart';
import 'package:app/widgets/on_boardring_page/custom_smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardringPageBottomSheet extends StatelessWidget {
  const OnBoardringPageBottomSheet(
      {super.key,
      required this.size,
      required this.controller,
      required this.isLastPage});

  final Size size;
  final PageController controller;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .135,
      width: size.width,
      color: kPrimaryColor,
      child: Column(
        children: [
          CustomSmoothPageIndicator(controller: controller, size: size),
          SizedBox(height: size.width * .06),
          CustomBottom(
              text: isLastPage ? 'Get Started' : 'Next',
              colorBottom: Colors.white,
              colorText: kPrimaryColor,
              onPressed: () {
                if (isLastPage) {
                } else {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
              },
              borderRadius: BorderRadius.circular(32),
              width: size.width * .8)
        ],
      ),
    );
  }
}
