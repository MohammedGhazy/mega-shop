import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/models/auth_models/user_model.dart';
import 'package:shop_app/models/cart_model/cart_model.dart';
import 'package:shop_app/models/cart_model/change_cart_model.dart';
import '../shared/constants.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  bool get isAuth {
    return token != null;
  }

  CartModel? cartModel;
  Map<int, bool> cart = {};
  int cartProductsNumber = 0;

  void getCartData() {
    emit(CartLoadingState());
    DioHelper.getData(
      url: CARTS,
      token: token,
      lang: appLanguage
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartSuccessState(cartModel!));
    }).catchError((error) {
      print(error.toString());
      emit(CartFailureState(error.toString()));
    });
  }

  ChangeCartModel? changeCartModel;

  void changeCartItem(int productID) {
    print(productID);
    changeLocalCart(productID);
    emit(ChangeCartLoadingState());
    DioHelper.postData(
        url: CHANGE_CARTS,
        data: {
          "product_id" : productID
        },
      token: token,
        lang: appLanguage
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      if(changeCartModel?.status == false)
      {changeLocalCart(productID);}
      getCartData();
      emit(ChangeCartSuccessState(changeCartModel!));
    }).catchError((error) {
      changeLocalCart(productID);
      print(error.toString());
      emit(ChangeCartFailureState(error.toString()));
    });
  }

  updateCart(int id, int quantity) {

    emit(UpdateCartLoadingState());
    DioHelper.putData(
        url: "$UPDATE_CARTS$id",
        data: {
          "quantity" : quantity
        },
        token: token,
    ).then((value) {
      print(value.data);
      getCartData();
      emit(UpdateCartSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(UpdateCartFailureState());
    });

  }

  void changeLocalCart(id)
  {
    cart[id] = !cart[id]!;

    if(cart[id] == true)
    {
      cartProductsNumber++;
    } else
    {
      cartProductsNumber--;
    }

    emit(ChangeCartLocalState());
  }

  UserModel? userModel;

  void getUserData(){
    emit(UserLoadingState());
    DioHelper.getData(
        url: GET_PROFILE,
      token: token,
        lang: appLanguage
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      print("this is user email ==> ${userModel?.data?.email ?? ''}");
      emit(UserSuccessState(userModel!));
    }).catchError((error) {
      print("this is user failure ==> ${error.toString()}");
      emit(UserFailureState(error.toString()));
    });
  }

  Future<void> getSavedLanguage() async {
    appLanguage =
    await CacheHelper.getData(key: "Locale");
    emit(AppChangeLocalState(locale: Locale(appLanguage)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await CacheHelper.saveData(key: "Locale", value: languageCode);
    emit(AppChangeLocalState(locale: Locale(languageCode)));
  }
}

// IconData modeIcon = Icons.light_mode_outlined;
  // ThemeMode themeAppMode = ThemeMode.light;
  //
  // void toggleModeIcon({bool? fromSharedPreferences}) {
  //   if(fromSharedPreferences == null) {
  //     if(modeIcon == Icons.dark_mode_outlined) {
  //       modeIcon = Icons.light_mode_outlined;
  //       CacheHelper.saveData(key: "isDark" , value:  true);
  //       themeAppMode = ThemeMode.dark;
  //     } else {
  //       CacheHelper.saveData(key: "isDark" , value:  false);
  //       modeIcon == Icons.dark_mode_outlined;
  //       themeAppMode = ThemeMode.light;
  //     }
  //   } else {
  //     modeIcon = fromSharedPreferences?Icons.light_mode_outlined:Icons.dark_mode_outlined;
  //     themeAppMode = fromSharedPreferences?ThemeMode.dark:ThemeMode.light;
  //   }
  //   emit(AppToggleModeIThemeState());
  // }