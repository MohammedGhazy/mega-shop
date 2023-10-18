import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/auth_screens/login_screen/ui/login_screen.dart';

import '../helper/cache_helper.dart';

Widget buildEmptyCartOrFavourite({required String msg}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/sad.webp",height: 150,width: 150,),
          const SizedBox(height: 20.0,),
          buildTitleText(text: msg)
        ],
      ),
    ),
  );
}

Widget buildTitleText({
   required String text,
    Color? textColor,
    FontWeight? fontWeight,
}) {
    return Text(
        text,
        style:  TextStyle(
            fontSize: 20.0,
            fontWeight: fontWeight ?? FontWeight.bold,
            color: textColor ?? Colors.black
        ),
    );
}

Widget buildDiscountText({
  required String text,
  double? fontSize,
  int? maxLines,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize ?? 14.0,
      color:  Colors.grey,
      overflow: TextOverflow.ellipsis,
      decoration: TextDecoration.lineThrough
    ),
    maxLines: maxLines ?? 3,
  );
}

Widget buildBodyText({
   required String text,
    Color? textColor,
    double? fontSize,
    int? maxLines,
    TextDecoration? decoration
}) {
    return Text(
        text,
        style: TextStyle(
            fontSize: fontSize ?? 14.0,
            color: textColor ?? Colors.grey,
            overflow: TextOverflow.ellipsis,
        ),
        maxLines: maxLines ?? 3,
    );
}

Widget buildCartButton({
  required void Function()? onTap,
  required String titleButton,
  required Color btnColor,
}) {
  return Material(
    elevation: 7.0,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    child: InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        height: 48,
        child:  Center(
            child: buildBodyText(
                text: titleButton,
                textColor: Colors.white
            )
        ),
      ),
    ),
  );
}

Widget buildAppButton({
  required void Function()? onTap,
  required String titleButton,
}) {
  return Material(
    elevation: 7.0,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    child: InkWell(
      onTap: onTap,
      child: Ink(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.indigo,Colors.indigoAccent]),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        height: 48,
        child:  Center(
          child: buildBodyText(
              text: titleButton,
            textColor: Colors.white
          )
        ),
      ),
    ),
  );
}

Widget buildTextFormField({
  required TextEditingController controller,
  required String hintText,
  required TextInputType keyboardType,
  required IconData prefixIcon,
  required String label,
  required Function validator,
  required Function onFieldSubmitted,
  IconData? suffixIcon,
  void Function()? suffixPress,
  bool isPassword = false,
}) {
  return TextFormField(
    obscureText: isPassword,
    controller: controller,
    keyboardType: keyboardType,
    onFieldSubmitted: (value) => onFieldSubmitted(value),
    validator: (input) => validator(input),
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(30)),
      filled: true,
      fillColor: Colors.grey[200],
      hoverColor: Colors.indigo,
      prefixIcon: Icon(prefixIcon),
      suffix: GestureDetector(
        onTap:  suffixPress,
          child: Icon(suffixIcon)),
      //TODO prefixIconColor: ,
      label: Text(label, style: TextStyle(color: Colors.grey[600])),
    )
  );
}

Future buildToast({
  required String msg,
  required ToastStates states,
}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(states),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates {SUCCESS , WARNING , ERROR}

Color chooseToastColor(ToastStates states) {
  Color color;
  switch(states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
    case ToastStates.WARNING:
      color = Colors.orange;
    case ToastStates.ERROR:
      color = Colors.red;
  }
  return color;
}

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: SizedBox(
              height: 142,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/logo.jpg",
                height: 100,
                width: 100,
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Contacts',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Complaints',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'FAQs',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        GestureDetector(
          onTap: (){
            CacheHelper.removeData(key: "token").then((value) {
              if(value!) {
                navigateAndFinish(context, const LoginScreen());
              }
            });
          },
          child: const Text(
            'Log Out',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=> widget)
);

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
        (Route<dynamic> route) => false,
);