import 'package:flutter/material.dart';
import 'package:nova_store/nova_store/Data/local_data.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/category_detail_screen.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key, required this.products, required this.model});
  final ClothesModel model;
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              CategoryDetailScreen(products: products, model: model),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade100,

              radius: 30,

              child: Image.asset(model.image, width: 37),
            ),
          ),
          Text(
            model.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
