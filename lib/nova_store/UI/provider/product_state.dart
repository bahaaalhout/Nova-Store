import 'package:nova_store/nova_store/Models/product_model.dart';

class ProductState {}

class OnInitialState extends ProductState {}

class OnLoadingState extends ProductState {}

class OnSuccessState extends ProductState {
  final List<ProductModel> products;

  OnSuccessState({required this.products});
}

class OnErrorState extends ProductState {
  final String errorMessage;

  OnErrorState({required this.errorMessage});
}

class OnCartUpdatedState extends ProductState {
  final List<ProductModel> cart;
  OnCartUpdatedState({required this.cart});
}
