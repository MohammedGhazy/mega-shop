import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/modules/auth_screens/login_screen/ui/login_screen.dart';
import 'package:shop_app/modules/onBoarding_screens/cubit/cubit.dart';
import 'package:shop_app/modules/onBoarding_screens/cubit/states.dart';
import 'package:shop_app/modules/onBoarding_screens/model/onboarding_model.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/pageView_component.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit , OnBoardingStates> (
        listener: (context , state) {},
        builder: (context , state) {
          var boardingCubit =  OnBoardingCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: (){
                      CacheHelper.saveData(
                          key: "onBoarding",
                          value: true
                      ).then((value) {
                        print(value);
                        if(value == true) {
                          navigateAndFinish(context, const LoginScreen());
                        }
                      });
                    },
                    child: const Text(
                        "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo
                      ),
                    )
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PageView.builder(
                      controller: boardingCubit.onBoardingController,
                      itemCount: boardingCubit.onBoardingItemList.length,
                        itemBuilder: (context , index) {
                          return buildPageViewComponent(boardingCubit.onBoardingItemList[index]);
                        },
                      onPageChanged: (int index) {
                        boardingCubit.checkLastIndex(index);
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildIndicatorAndButton(
                        controller: boardingCubit.onBoardingController,
                        pagesCount: boardingCubit.onBoardingItemList.length,
                        floatingButtonTap: () {
                          if(boardingCubit.isLastIndex == true) {
                            CacheHelper.saveData(
                                key: "onBoarding",
                                value: true
                            ).then((value) {
                              print(value);
                              if(value == true) {
                                navigateAndFinish(context, const LoginScreen());
                              }
                            });
                          } else {
                            boardingCubit.onBoardingController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn
                            );
                          }
                        }
                    )
                  )
                ],
              ),
            )
          );
        },
      )
    );
  }
}
