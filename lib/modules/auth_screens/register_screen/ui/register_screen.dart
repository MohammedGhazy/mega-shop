import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/auth_screens/login_screen/ui/login_screen.dart';
import 'package:shop_app/modules/auth_screens/register_screen/cubit/cubit.dart';
import 'package:shop_app/modules/auth_screens/register_screen/cubit/states.dart';
import 'package:shop_app/shared/componants.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit , RegisterStates> (
          listener: (context , state) {
            if(state is RegisterSuccessState) {
              if(state.userRegisterModel.status == true) {
                buildToast(
                    msg: state.userRegisterModel.message!,
                    states: ToastStates.SUCCESS
                );
                navigateTo(context, const LoginScreen());
              } else {
                buildToast(
                    msg: state.userRegisterModel.message!,
                    states: ToastStates.ERROR
                );
              }
            }
          },
          builder: (context , state) {
            var cubit = RegisterCubit.get(context);
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30,),
                        Center(
                          child: buildTitleText(
                              text: "Register Now",
                              textColor: Colors.indigo
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Center(
                            child: buildBodyText(
                                text: "Create Account to \n enjoy our products!",
                                textColor: Colors.black,
                                fontSize: 22
                            )
                        ),
                        const SizedBox(height: 20,),
                        buildTextFormField(
                            controller: cubit.nameController,
                            hintText: "Enter Your Name",
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.person,
                            label: 'Enter Your Name',
                            validator: (String value){
                              if(value.isEmpty) {
                                return "name is empty";
                              }
                            },
                            onFieldSubmitted: (){}
                        ),
                        const SizedBox(height: 40,),
                        buildTextFormField(
                            controller: cubit.emailController,
                            hintText: "Enter Your Email",
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.person,
                            label: 'Enter Your Email',
                            validator: (String value){
                              if(value.isEmpty) {
                                return "email is empty";
                              }
                            },
                            onFieldSubmitted: (){}
                        ),
                        const SizedBox(height: 40,),
                        buildTextFormField(
                            controller: cubit.phoneController,
                            hintText: "Enter Your Phone",
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.person,
                            label: 'Enter Your Phone',
                            validator: (String value){
                              if(value.isEmpty) {
                                return "phone is empty";
                              }
                            },
                            onFieldSubmitted: (){}
                        ),
                        const SizedBox(height: 20,),
                        buildTextFormField(
                            controller: cubit.passwordController,
                            hintText: "Enter Your Password",
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: Icons.password,
                            suffixIcon: cubit.suffixIcon,
                            suffixPress: () {
                              cubit.changePasswordVisibility();
                            },
                            isPassword: cubit.isPassword,
                            label: 'Enter Your Password',
                            validator: (String value){
                              if(value.isEmpty) {
                                return "password is too short";
                              }
                            },
                            onFieldSubmitted: (){}
                        ),
                        const SizedBox(height: 20,),
                       state is RegisterLoadingState ?
                        const Center(child: CircularProgressIndicator(),)
                           :
                           state is RegisterFailureState ?
                        Center(child: buildTitleText(text: state.failure),)
                               : state is RegisterSuccessState ?
                        buildAppButton(
                            onTap: (){
                              if(cubit.formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    name: cubit.nameController.text,
                                    email: cubit.emailController.text,
                                    phone: cubit.phoneController.text,
                                    password: cubit.passwordController.text
                                );
                              }
                            },
                            titleButton: "Sign Up"
                        ) : Container(),
                        const SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: (){
                                navigateTo(context, const LoginScreen());
                              },
                              child: buildBodyText(
                                  text: 'Already Have An Account',
                                  textColor: Colors.black
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
