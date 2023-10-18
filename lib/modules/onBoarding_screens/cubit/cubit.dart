import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/modules/onBoarding_screens/cubit/states.dart';

import '../../../shared/componants.dart';
import '../../auth_screens/login_screen/ui/login_screen.dart';
import '../model/onboarding_model.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitState());
  static OnBoardingCubit get(BuildContext context) => BlocProvider.of(context);


  var onBoardingController = PageController();
  var isLastIndex = false;

  List<OnBoardingModel> onBoardingItemList = [
    OnBoardingModel(
        image: "assets/images/boarding_1.jpg",
        bodyText: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it",
        titleText: "title Boarding 1"
    ),
    OnBoardingModel(
        image: "assets/images/boarding_2.jpg",
        bodyText: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it",
        titleText: "title Boarding 2"
    ),
    OnBoardingModel(
        image: "assets/images/boarding_3.png",
        bodyText: "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it",
        titleText: "title Boarding 3"
    )
  ];

  void checkLastIndex(int index) {
    if(index == onBoardingItemList.length - 1) {
      print("last");
      isLastIndex = true;
    } else {
      print("not last");
      isLastIndex = false;
    }
    emit(OnBoardingLastIndexState());
  }
}