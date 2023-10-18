import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/models/home_model/category_model.dart';
import 'package:shop_app/models/favourites_model/change_favourite_model.dart';
import 'package:shop_app/models/favourites_model/favourite_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/modules/main_screens/categories_screen/ui/categories_screen.dart';
import 'package:shop_app/modules/main_screens/favourite_screen/ui/favourite_screen.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/states.dart';
import 'package:shop_app/modules/main_screens/home_screen/ui/home_screen.dart';
import 'package:shop_app/modules/main_screens/setting_screen/ui/settings_screen.dart';
import '../../../../shared/constants.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutInitState());
  static HomeLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = Screens.business.index;

  final List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];

  late List<DotNavigationBarItem> bottomNavigationItems = [
    DotNavigationBarItem(
        icon: const Icon(Icons.home_filled),),
    DotNavigationBarItem(
        icon: const Icon(Icons.category_outlined),),
    DotNavigationBarItem(
        icon: const Icon(Icons.favorite),),
    DotNavigationBarItem(
      icon: const Icon(Icons.settings),),
  ];

  void changeScreenIndex(int index) {
    currentIndex = index;
    emit(HomeChangeScreenIndexState());
  }

  HomeModel? homeModel;
  CategoryModel? categoryModel;
  ChangeFavouriteModel? changeFavouriteModel;
  FavouriteModel? favouriteModel;
  Map<int, bool> favourites = {};


  void getHomeData(BuildContext context) {
    emit(HomeLoadingState());
    DioHelper.getData(
        url: HOME,
        token: token,
      lang: appLanguage,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.newProducts?.forEach((element) {
        favourites.addAll({
          element.id! : element.inFavorites!
        });
        AppCubit.get(context).cart.addAll({
          element.id! : element.inCart!
        });
        if(element.inCart!) {
          AppCubit.get(context).cartProductsNumber++;
        }
      });

      if (kDebugMode) {
        print("this is token when request complete ====> $token");
      }
      emit(HomeSuccessState(homeModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(HomeFailureState(error.toString()));
    });
  }

  void getCategoriesData() {
    emit(HomeLoadingState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
        lang: appLanguage
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategorySuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CategoryFailureState(error.toString()));
    });
  }

  void getFavouriteData() {
    emit(GetFavouriteLoadingState());
    DioHelper.getData(
        url: GET_Favourites,
      token: token,
        lang: appLanguage
    ).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      emit(FavouriteSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(FavouriteFailureState(error.toString()));
    });
  }

  void changeFavourite(int productID) {
    favourites[productID] = !favourites[productID]!;
    emit(ChangeFavLoadingState());
    DioHelper.postData(
        url: CHANGE_FAVOURITES,
        data: {
          "product_id" : productID
        },
        token: token,
        lang: appLanguage
    ).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      if(changeFavouriteModel?.status == false) {
        favourites[productID] = !favourites[productID]!;
      } else {
        getFavouriteData();
      }
      emit(ChangeFavouriteSuccessState(changeFavouriteModel!));
    }).catchError((error) {
      favourites[productID] = !favourites[productID]!;
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ChangeFavouriteFailureState());
    });
  }
}