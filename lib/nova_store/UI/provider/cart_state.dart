import 'package:nova_store/nova_store/Models/product_model.dart';

class CartState {}

class OnInitialState extends CartState {}

class OnLoadingState extends CartState {}

class OnSuccessState extends CartState {
  final List<ProductModel> cart;

  OnSuccessState({required this.cart});
}

class OnErrorState extends CartState {
  final String errorMesssage;

  OnErrorState({required this.errorMesssage});
}
