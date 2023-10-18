import 'package:flutter/material.dart';
import 'package:shop_app/models/auth_models/user_model.dart';
import 'package:shop_app/models/cart_model/cart_model.dart';
import 'package:shop_app/models/cart_model/change_cart_model.dart';

abstract class AppStates {}
class AppInitState extends AppStates{}

class AppToggleModeIThemeState extends AppStates{}

class AppLoadingState extends AppStates{}

class CartLoadingState extends AppStates{}

class CartSuccessState extends AppStates{
  final CartModel cartModel;
  CartSuccessState(this.cartModel);
}

class CartFailureState extends AppStates{
  final String failure;
  CartFailureState(this.failure);
}

class ChangeCartLoadingState extends AppStates{}

class ChangeCartSuccessState extends AppStates{
  final ChangeCartModel changeCartModel;
  ChangeCartSuccessState(this.changeCartModel);
}

class ChangeCartFailureState extends AppStates{
  final String failure;
  ChangeCartFailureState(this.failure);
}

class ChangeCartLocalState extends AppStates {}

class UpdateCartLoadingState extends AppStates{}

class UpdateCartSuccessState extends AppStates{}

class UpdateCartFailureState extends AppStates{}

class UserLoadingState extends AppStates{}

class UserSuccessState extends AppStates{
  final UserModel userModel;
  UserSuccessState(this.userModel);
}

class UserFailureState extends AppStates{
  final String failure;
  UserFailureState(this.failure);
}

class AppChangeLocalState extends AppStates{
  final Locale locale;
  AppChangeLocalState({required this.locale});
}
