import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helper/dio_helper.dart';
import 'package:shop_app/models/category_products_model/product_detail_model.dart';
import 'package:shop_app/modules/main_screens/detail_screen/cubit/states.dart';
import 'package:shop_app/shared/constants.dart';

class ProductsDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductsDetailsCubit() : super(DetailsInitialState());
  static ProductsDetailsCubit get(context) => BlocProvider.of(context);

  ProductDetailModel? productDetailModel;
  void getProductDetailData(int id) {
    emit(DetailLoadingState());
    DioHelper.getData(
        url: "$PRODUCT_DETAIL$id",
        token: token,
        lang: appLanguage
    ).then((value) {
      productDetailModel = ProductDetailModel.fromJson(value.data);
      emit(DetailSuccessState(productDetailModel!));
    }).catchError((error) {
      //checkException(error);
      debugPrint(error.toString());
      emit(DetailFailureState(error.toString()));
    });
  }
}