import 'package:flutter/material.dart';



enum Screens { business, sport, science, search }
// colors and styles
const Color kDarkModeColor = Color(0XFF212f3d);
const Color kOrangeColor = Colors.indigo;
const MaterialColor kOrangeMaterialColor = Colors.indigo;
const double kHorizontalPaddingValue = 15.0;

// Auth EndPoints
const LOGIN                 = "login";
const REGISTER              = "register";
const HOME                  = "home";
const GET_CATEGORIES        = "categories";
const GET_CATEGORY_PRODUCTS = "products?category_id=";
const GET_Favourites        = "favorites";
const CHANGE_FAVOURITES     = "favorites";
const PRODUCT_DETAIL        = "products/";
const CARTS                 = "carts";
const CHANGE_CARTS          = "carts";
const UPDATE_CARTS          = "carts/";
const GET_PROFILE           = "profile";

// token
String? token;
String appLanguage = "en";
