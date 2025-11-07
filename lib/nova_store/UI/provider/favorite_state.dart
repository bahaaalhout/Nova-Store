import 'package:nova_store/nova_store/Models/product_model.dart';

class FavoriteState {}

class OnInitialState extends FavoriteState {}

class OnLoadingState extends FavoriteState {}

class OnSuccessState extends FavoriteState {
  final List<ProductModel> favorite;

  OnSuccessState({required this.favorite});
}

class OnErrorState extends FavoriteState {
  final String errorMesssage;

  OnErrorState({required this.errorMesssage});
}
