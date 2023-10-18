abstract class CategoryProductStates {}

class ProductInitialState extends CategoryProductStates {}

class ProductLoadingState extends CategoryProductStates {}

class ProductSuccessState extends CategoryProductStates {}

class ProductFailureState extends CategoryProductStates {
  final String failure;
  ProductFailureState(this.failure);
}
