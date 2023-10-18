import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/models/auth_models/user_login_model.dart';
import 'package:shop_app/modules/auth_screens/login_screen/cubit/states.dart';
import 'package:shop_app/shared/constants.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserLoginModel? userLoginModel;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ?   Icons.visibility_outlined : Icons.visibility_off;
    emit(LoginPasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          "email" : email,
          "password" : password,
        }
    ).then((value) {
      print(value.data);
      userLoginModel = UserLoginModel.fromJson(value.data);
      emit(LoginSuccessState(userLoginModel!));
    }).catchError((error){
        print(error.toString());
        emit(LoginFailureState(error.toString()));
    });
  }
}