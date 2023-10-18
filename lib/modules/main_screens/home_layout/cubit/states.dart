import 'package:shop_app/models/home_model/category_model.dart';
import 'package:shop_app/models/favourites_model/change_favourite_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';

abstract class HomeLayoutStates {}

class HomeLayoutInitState extends HomeLayoutStates {}

class HomeChangeScreenIndexState extends HomeLayoutStates {}

class HomeLoadingState extends HomeLayoutStates{}

class HomeSuccessState extends HomeLayoutStates{
  final HomeModel homeModel;
  HomeSuccessState(this.homeModel);
}

class HomeFailureState extends HomeLayoutStates{
  final String error;
  HomeFailureState(this.error);
}

class CategorySuccessState extends HomeLayoutStates{}

class CategoryFailureState extends HomeLayoutStates{
  final String failure;
  CategoryFailureState(this.failure);
}

class ChangeFavouriteSuccessState extends HomeLayoutStates{
  final ChangeFavouriteModel changeFavouriteModel;
  ChangeFavouriteSuccessState(this.changeFavouriteModel);
}

class FavouriteLoadingState extends HomeLayoutStates{}

class GetFavouriteLoadingState extends HomeLayoutStates{}

class FavouriteSuccessState extends HomeLayoutStates{}

class FavouriteFailureState extends HomeLayoutStates{
  final String failure;
  FavouriteFailureState(this.failure);
}

class ChangeFavLoadingState extends HomeLayoutStates{}

class ChangeFavouriteFailureState extends HomeLayoutStates{}