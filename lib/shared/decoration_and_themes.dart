import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: kOrangeMaterialColor,
  fontFamily: "Young_Serif",
  appBarTheme: const AppBarTheme(
    titleSpacing: kHorizontalPaddingValue,
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: kDarkModeColor,
      fontWeight: FontWeight.bold,
      fontSize: 25.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: kOrangeColor,
    elevation: 20.0,
  ),
);

final ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      titleSpacing: kHorizontalPaddingValue,
      backgroundColor: kDarkModeColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: kDarkModeColor,
        statusBarIconBrightness: Brightness.dark,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: kDarkModeColor,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.white,
    elevation: 20.0,
  ),
  scaffoldBackgroundColor: kDarkModeColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);



final InputDecoration kInputDecoration = InputDecoration(
  border: OutlineInputBorder(
      borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.indigo),
      borderRadius: BorderRadius.circular(30)),
  filled: true,
  fillColor: Colors.grey[200],
  hoverColor: Colors.indigo,
  prefixIcon: Icon(
    Icons.search_outlined,
    color: Colors.grey[400],
  ),
  //TODO prefixIconColor: ,
  label: Text('search', style: TextStyle(color: Colors.grey[600])),
);
