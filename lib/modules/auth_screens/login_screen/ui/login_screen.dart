import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/modules/auth_screens/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/auth_screens/login_screen/cubit/states.dart';
import 'package:shop_app/modules/auth_screens/register_screen/ui/register_screen.dart';
import 'package:shop_app/modules/main_screens/home_layout/ui/home_layout.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:shop_app/shared/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.userLoginModel.status == true) {
              // go to home screen
              CacheHelper.saveData(
                      key: "token", value: state.userLoginModel.data?.token)
                  .then((value) {
                token = state.userLoginModel.data?.token;
                print("this is my token ---> $token}");
                navigateAndFinish(context, const HomeLayout());
              });
            } else {
              buildToast(
                  msg: state.userLoginModel.message!,
                  states: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: loginCubit.formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: buildTitleText(
                              text: "Login Here", textColor: Colors.indigo),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: buildBodyText(
                                text: "Welcome Back You've \n been missed !",
                                textColor: Colors.black,
                                fontSize: 22)),
                        const SizedBox(
                          height: 40,
                        ),
                        buildTextFormField(
                            controller: loginCubit.emailController,
                            hintText: "Enter Your Email",
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.person,
                            label: 'Enter Your Email',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "email is empty";
                              }
                            },
                            onFieldSubmitted: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                        buildTextFormField(
                            controller: loginCubit.passwordController,
                            hintText: "Enter Your Password",
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: Icons.password,
                            suffixIcon: loginCubit.suffixIcon,
                            suffixPress: () {
                              loginCubit.changePasswordVisibility();
                            },
                            isPassword: loginCubit.isPassword,
                            label: 'Enter Your Password',
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "password is too short";
                              }
                            },
                            onFieldSubmitted: () {}),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                              onPressed: () {},
                              child: buildBodyText(
                                  text: 'Forgot Your Password ?',
                                  textColor: Colors.indigo)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is LoginFailureState ?
                        Center(child: buildTitleText(text: state.failure ),) :
                            state is LoginLoadingState ?
                        const Center(child: CircularProgressIndicator(),) :
                        buildAppButton(
                            onTap: () {
                              if (loginCubit.formKey.currentState!.validate()) {
                                loginCubit.userLogin(
                                    email: loginCubit.emailController.text,
                                    password:
                                        loginCubit.passwordController.text);
                              }
                            },
                            titleButton: "Sign In"),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: () {
                                navigateTo(context, const RegisterScreen());
                              },
                              child: buildBodyText(
                                  text: 'Create New Account',
                                  textColor: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
