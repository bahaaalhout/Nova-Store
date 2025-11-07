import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/cart_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/cart_state.dart';

import 'package:nova_store/nova_store/UI/screens/cart_screen/widgets/cart_list.dart';
import 'package:nova_store/nova_store/UI/widgets/snack_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int delivaryPrice = 35;
    TextStyle style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        List<ProductModel> cart = [];

        if (state is OnSuccessState) {
          cart = state.cart;
        } else if (state is OnErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ShowSnackBar().snackBar(context, state.errorMesssage);
          });
        }
        double totalPrices = 0;
        for (var element in cart) {
          totalPrices += element.price;
        }

        return state is OnLoadingState
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.blue.withValues(alpha: 0.1),
                          child: Text(
                            'My Cart',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) =>
                          CartList(cart: cart[index]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 150,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Products Prices', style: style),
                            Text(totalPrices.toStringAsFixed(2), style: style),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivary Price', style: style),
                            Text(
                              cart.isEmpty ? '0' : '$delivaryPrice',
                              style: style,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Products Taxs', style: style),
                            Text('${(cart.length * 0.1)}', style: style),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: style),
                            Text(
                              '${(cart.length * 0.1) + (cart.isEmpty ? 0 : delivaryPrice) + totalPrices}',
                              style: style,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}
