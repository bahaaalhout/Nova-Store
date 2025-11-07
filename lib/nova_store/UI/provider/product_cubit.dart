import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/Models/product_repositry.dart';
import 'package:nova_store/nova_store/UI/provider/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(OnInitialState());
  List<ProductModel> products = [];

  Future<void> fetchData() async {
    emit(OnLoadingState());

    try {
      final fetchedList = await ProductRepositry.fetchData();
      products = fetchedList;
      log('✅ Fetched ${products.length} products');
      emit(OnSuccessState(products: products));
    } catch (e, s) {
      log('❌ Error in fetchData: $e');
      log('$s');
      emit(OnErrorState(errorMessage: e.toString()));
    }
  }
}
