import 'dart:convert';

import 'package:http/http.dart';
import 'package:nova_shop/Nova%20Shop/Models/product_model.dart';

class ProductRepositry {
  Future<List<ProductModel>> fetchData() async {
    Response response = await get(
      Uri.parse('https://dummyjson.com/products/category/mens-shirts'),
    );
    var data = jsonDecode(response.body);
    List<ProductModel> products = [];
    for (var item in data) {
      products.add(ProductModel.fromJson(item));
    }
    return products;
  }
}
