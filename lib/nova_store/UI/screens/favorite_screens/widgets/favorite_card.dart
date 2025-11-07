import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/cart_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/cart_state.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_cubit.dart';
import 'package:nova_store/nova_store/UI/widgets/snack_bar.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.favorite});
  final ProductModel favorite;
  @override
  Widget build(BuildContext context) {
    var cart = BlocProvider.of<CartCubit>(context);
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<FavoriteCubit>(context).removeProduct(favorite);
            },
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.grey,
              size: 25,
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.network(favorite.thumbnail),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favorite.title,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('\$ ${favorite.price}', style: TextStyle(fontSize: 15)),
                ElevatedButton(
                  onPressed: () {
                    if (cart.isInCart(favorite)) {
                      ShowSnackBar().snackBar(context, 'Already In Cart');
                      return;
                    }
                    cart.addProduct(favorite);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    elevation: WidgetStatePropertyAll(2),
                  ),
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) => Text(
                      cart.isInCart(favorite) ? 'In Cart' : 'ADD to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
