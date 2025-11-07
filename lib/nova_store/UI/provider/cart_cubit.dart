import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(OnInitialState());
  List<ProductModel> cart = [];
  addProduct(ProductModel productModel) {
    emit(OnLoadingState());
    if (cart.contains(productModel)) {
      emit(OnErrorState(errorMesssage: 'Already Added'));
      emit(OnSuccessState(cart: cart));
      return;
    }
    cart.add(productModel);

    emit(OnSuccessState(cart: cart));
  }

  removeProduct(ProductModel productModel) {
    emit(OnLoadingState());
    cart.remove(productModel);

    emit(OnSuccessState(cart: cart));
  }

  cleanProduct() {
    emit(OnLoadingState());
    cart.clear();
    emit(OnSuccessState(cart: cart));
  }

  bool isInCart(ProductModel productModel) {
    for (var element in cart) {
      if (element.id == productModel.id) {
        return true;
      }
    }
    return false;
  }
}
