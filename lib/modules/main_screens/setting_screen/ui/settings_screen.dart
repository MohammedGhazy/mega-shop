import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/states.dart';
import 'package:shop_app/modules/main_screens/setting_screen/wigets/widgets.dart';
import 'package:shop_app/shared/componants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AppCubit>(context, listen: false).getUserData();
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ListView(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                cubit.userModel != null
                    ? buildProfileInSettingScreen(cubit.userModel!)
                    : Container(),
                buildSeparator(),
                const SizedBox(height: 10.0,),

                buildSettings(
                    context: context,
                    langValue: state is AppChangeLocalState ? state.locale.languageCode : "en"
                ),
              ],
            ),
          );
        });
  }
}
