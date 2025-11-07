import 'dart:convert';

import 'package:http/http.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';

class ProductRepositry {
  static List<String> apiLinks = [
    'https://dummyjson.com/products/category/mens-shirts',
    'https://dummyjson.com/products/category/mens-shoes',
    'https://dummyjson.com/products/category/mens-watches',
    'https://dummyjson.com/products/category/womens-dresses',
    'https://dummyjson.com/products/category/womens-shoes',
    'https://dummyjson.com/products/category/womens-watches',
    'https://dummyjson.com/products/category/womens-bags',
    'https://dummyjson.com/products/category/womens-jewellery',
  ];
  static Future<List<ProductModel>> fetchData() async {
    List<ProductModel> allProducts = [];
    for (var api in apiLinks) {
      final response = await get(Uri.parse(api));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List products = data['products'];
        allProducts.addAll(
          products.map((e) => ProductModel.fromJson(e)).toList(),
        );
      } else {
        throw Exception('Failed to load products');
      }
    }
    return allProducts;
  }
}
