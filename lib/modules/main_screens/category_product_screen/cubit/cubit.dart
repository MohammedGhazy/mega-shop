import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/models/category_products_model/category_products_model.dart';
import 'package:shop_app/modules/main_screens/category_product_screen/cubit/states.dart';
import 'package:shop_app/modules/main_screens/home_layout/cubit/cubit.dart';
import 'package:shop_app/shared/constants.dart';

class CategoryProductCubit extends Cubit<CategoryProductStates> {
  CategoryProductCubit() : super(ProductInitialState());
  static CategoryProductCubit get(BuildContext context) => BlocProvider.of(context);

  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey();
  CategoryProductModel? categoryProductsModel;
  void getCategoryProductsData(int categoryID , BuildContext context) {
    emit(ProductLoadingState());
    DioHelper.getData(
      url: "$GET_CATEGORY_PRODUCTS$categoryID",
      token: token,
        lang: appLanguage
    ).then((value) {
      categoryProductsModel = CategoryProductModel.fromJson(value.data);
      categoryProductsModel!.data!.data?.forEach((element) {
        if(!HomeLayoutCubit.get(context).favourites.containsKey(element.id)){
          HomeLayoutCubit.get(context).favourites.addAll({
            element.id! : element.inFavorites!
          });
        }
        if(!AppCubit.get(context).cart.containsKey(element.id)) {
          AppCubit.get(context).cart.addAll({
            element.id! : element.inCart!
          });
        }
      });
      emit(ProductSuccessState());
    }).catchError(
        (error) {
          if (kDebugMode) {
            print(error.toString());
          }
          emit(ProductFailureState(error.toString()));
        }
    );
  }
}