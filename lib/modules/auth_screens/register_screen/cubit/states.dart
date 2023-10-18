import 'package:shop_app/models/auth_models/user_register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterPasswordVisibilityState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final UserRegisterModel userRegisterModel;
  RegisterSuccessState(this.userRegisterModel);
}

class RegisterFailureState extends RegisterStates {
  final String failure;
  RegisterFailureState(this.failure);
}