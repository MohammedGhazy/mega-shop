import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/models/auth_models/user_model.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:shop_app/shared/localization/app_localization.dart';

Widget buildProfileInSettingScreen(UserModel userModel) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(userModel.data?.image ??
                "https://cdn.pixabay.com/photo/2021/07/25/08/03/account-6491185_960_720.png")),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleText(text: userModel.data?.name ?? "user"),
            const SizedBox(
              height: 10.0,
            ),
            buildBodyText(text: userModel.data?.phone ?? "user phone"),
          ],
        )
      ],
    ),
  );
}

Widget buildSeparator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    ),
  );
}

Widget buildSettings({
  required BuildContext context,
  required String langValue,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBodyText(text: "Language",fontSize: 18,textColor: Colors.black),
            DropdownButton<String>(
              value: langValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: ['ar', 'en'].map((String items) {
                return DropdownMenuItem<String>(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  AppCubit.get(context).changeLanguage(newValue);
                }
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        buildSeparator(),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBodyText(text: "Mode",fontSize: 18,textColor: Colors.black),
            buildBodyText(text: "Mode",fontSize: 18,textColor: Colors.black),
          ],
        ),
        buildSeparator(),
        const SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          onTap: () {
            //todo--
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildBodyText(text: "Edit Profile",fontSize: 18,textColor: Colors.black),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ],
    ),
  );
}
