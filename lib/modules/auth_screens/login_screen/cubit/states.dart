import 'package:shop_app/models/auth_models/user_login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final UserLoginModel userLoginModel;
  LoginSuccessState(this.userLoginModel);
}

class LoginFailureState extends LoginStates{
  final String failure;
  LoginFailureState(this.failure);
}

class LoginPasswordVisibilityState extends LoginStates{}