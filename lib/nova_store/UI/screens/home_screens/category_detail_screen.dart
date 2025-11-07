import 'package:flutter/material.dart';
import 'package:nova_store/nova_store/Data/local_data.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/card_section.dart';

class CategoryDetailScreen extends StatelessWidget {
  CategoryDetailScreen({super.key, required this.products, this.model});
  final ClothesModel? model;
  final List<ProductModel> products;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<ProductModel> filteredList = filterList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
        ),
        title: SizedBox(
          height: 45,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for Items',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Color(0xffF0EEF1),
              filled: true,
              prefixIconColor: Colors.grey.shade600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model!.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  Text(
                    '${filteredList.length} Items',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueGrey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                mainAxisSpacing: 10,
              ),

              itemCount: filteredList.length,
              itemBuilder: (BuildContext context, int index) {
                return CardSection(product: filteredList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  filterList() {
    List<ProductModel> filteredList = [];
    products.where((element) {
      for (var e in model!.category) {
        if (element.category == e) {
          filteredList.add(element);
        }
      }
      return true;
    }).toList();
    return filteredList;
  }
}
