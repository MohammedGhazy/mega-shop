import 'package:shop_app/models/category_products_model/product_detail_model.dart';

abstract class ProductDetailsStates {}

class DetailsInitialState extends ProductDetailsStates {}

class DetailLoadingState extends ProductDetailsStates{}

class DetailSuccessState extends ProductDetailsStates{
  final ProductDetailModel productDetailModel;
  DetailSuccessState(this.productDetailModel);
}

class DetailFailureState extends ProductDetailsStates{
  final String error;
  DetailFailureState(this.error);
}