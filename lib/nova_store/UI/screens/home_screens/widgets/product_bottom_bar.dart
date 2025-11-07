import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/cart_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/cart_state.dart';

import 'package:nova_store/nova_store/UI/screens/main_screen.dart';
import 'package:nova_store/nova_store/UI/widgets/snack_bar.dart';

class ProductBottomBar extends StatefulWidget {
  const ProductBottomBar({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductBottomBar> createState() => _ProductBottomBarState();
}

class _ProductBottomBarState extends State<ProductBottomBar> {
  late double currentPrice;

  @override
  void initState() {
    super.initState();
    currentPrice = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    var cartCubit = context.read<CartCubit>();
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product Price ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                '\$${currentPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) => ElevatedButton(
                      onPressed: () {
                        if (cartCubit.isInCart(widget.product)) {
                          ShowSnackBar().snackBar(context, 'Already In Cart');
                          return;
                        }
                        cartCubit.addProduct(widget.product);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.blueGrey.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        cartCubit.isInCart(widget.product)
                            ? 'In Cart'
                            : 'ADD TO CART',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MainScreen(selectedIndex: 2),
                      ),
                    );
                  },
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      final cartLength = context.read<CartCubit>().cart.length;
                      if (state is OnErrorState) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ShowSnackBar().snackBar(context, state.errorMesssage);
                        });
                      }
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD8EBFF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: Badge.count(
                          count: cartLength,
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      );
                    },
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
