import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/models/auth_models/user_register_model.dart';
import 'package:shop_app/modules/auth_screens/register_screen/cubit/states.dart';
import 'package:shop_app/shared/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserRegisterModel? userRegisterModel;

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ?   Icons.visibility_outlined : Icons.visibility_off;
    emit(RegisterPasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          "name" : name,
          "email" : email,
          "phone" : phone,
          "password" : password,
        }
    ).then((value) {
      print(value.data);
      userRegisterModel = UserRegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(userRegisterModel!));
    }).catchError((error){
      print(error);
      emit(RegisterFailureState(error.toString()));
    });
  }
}