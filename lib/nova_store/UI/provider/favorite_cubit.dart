import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Data/sqlite_db.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(OnInitialState());

  List<ProductModel> favorite = [];
  initProduct() async {
    emit(OnLoadingState());
    final products = await ProductSqliteDb.getProducts();
    try {
      favorite
        ..clear()
        ..addAll(products);
      emit(OnSuccessState(favorite: favorite));
    } catch (e) {
      emit(OnErrorState(errorMesssage: e.toString()));
    }
    emit(OnSuccessState(favorite: products));
  }

  addProduct(ProductModel productModel) async {
    emit(OnLoadingState());
    await ProductSqliteDb.insertProduct(productModel);
    favorite.add(productModel);

    emit(OnSuccessState(favorite: favorite));
  }

  removeProduct(ProductModel productModel) async {
    emit(OnLoadingState());
    await ProductSqliteDb.deleteProduct(productModel.id);
    favorite.remove(productModel);

    emit(OnSuccessState(favorite: favorite));
  }

  cleanProduct() {
    emit(OnLoadingState());

    favorite.clear();
    emit(OnSuccessState(favorite: favorite));
  }

  bool isInFavorite(ProductModel productModel) {
    for (var element in favorite) {
      if (element.id == productModel.id) {
        return true;
      }
    }
    return false;
  }
}
