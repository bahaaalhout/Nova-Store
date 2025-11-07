import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/cart_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/cart_state.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/product_screen.dart';

class CardSection extends StatelessWidget {
  const CardSection({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 350,
      width: 200,

      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductScreen(product: product),
            ),
          );
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                product.thumbnail,
                width: double.infinity,
                height: 200,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Text(
                    product.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) => IconButton(
                        onPressed: () {
                          var cubit = BlocProvider.of<CartCubit>(context);
                          if (cubit.isInCart(product)) {
                            cubit.removeProduct(product);
                            return;
                          }
                          cubit.addProduct(product);
                        },
                        icon:
                            BlocProvider.of<CartCubit>(
                              context,
                            ).isInCart(product)
                            ? Icon(Icons.check)
                            : Icon(Icons.add_shopping_cart_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  product.stock != 0 ? 'In Stock' : 'Out of Stock',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${product.rating} ★ ',
                    style: TextStyle(color: Colors.amber, fontSize: 17),
                  ),
                  Text(
                    '(${product.reviews.length})',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
