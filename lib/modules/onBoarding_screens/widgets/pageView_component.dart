import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop_app/modules/onBoarding_screens/model/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/componants.dart';

Widget buildPageViewComponent(OnBoardingModel onBoardingModel) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Image.asset(onBoardingModel.image,fit: BoxFit.cover,)
        ),
        const SizedBox(height: 20.0,),
        buildTitleText(
            text: onBoardingModel.titleText
        ),
        const SizedBox(height: 20.0,),
        buildBodyText(
         text: onBoardingModel.bodyText
        ),
      ],
    ),
  );
}

Widget buildIndicatorAndButton({
  required PageController controller,
  required int pagesCount,
  required void Function()? floatingButtonTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SmoothPageIndicator(
        controller: controller, // PageController
        count:  pagesCount,
        effect:  const ExpandingDotsEffect(
            dotWidth: 10.0,
            dotHeight: 10.0,
            spacing: 8.0,
            dotColor: Colors.grey,
            activeDotColor: Colors.indigo
        ),  // your preferred effect
      ),
      FloatingActionButton(
        onPressed: floatingButtonTap,
        child: const Icon(Icons.arrow_forward_ios_outlined),
      )
    ],
  );
}

