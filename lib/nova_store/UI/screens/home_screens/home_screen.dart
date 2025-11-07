import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Data/local_data.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/product_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/product_state.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/products_screen.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/bar_section.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/card_section.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/category_icon.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/discount_section.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/slider_section.dart';
import 'package:nova_store/nova_store/UI/widgets/snack_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var categories = ClothesModel.categories;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        List<ProductModel> products = [];

        if (state is OnSuccessState) {
          products = state.products;
        } else if (state is OnErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ShowSnackBar().snackBar(context, state.errorMessage);
          });
        }
        List<ProductModel> dresses = products
            .where((element) => element.category == 'womens-dresses')
            .toList();
        // List<ProductModel> watches = products
        //     .where(
        //       (element) =>
        //           element.category == 'mens-watches' ||
        //           element.category == 'womens-watches',
        //     )
        //     .toList();
        return state is OnLoadingState
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 115,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryIcon(
                            products: products,
                            model: categories[index],
                          );
                        },
                        itemCount: categories.length,
                      ),
                    ),

                    SliderSection(),
                    SizedBox(height: 10),
                    BarSection(
                      content: 'On Sale Today ⚡',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductsScreen(products: products),
                          ),
                        );
                      },
                    ),

                    DiscountSection(products: products),
                    SizedBox(height: 20),
                    BarSection(
                      content: 'Dresses 🔥',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductsScreen(products: dresses),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: dresses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardSection(product: dresses[index]);
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
