import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/cart_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/cart_state.dart';

class CartList extends StatefulWidget {
  const CartList({super.key, required this.cart});
  final ProductModel cart;

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  int currentIndex = 1;
  late double currentPrice;

  @override
  void initState() {
    super.initState();
    currentPrice = widget.cart.price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.network(widget.cart.thumbnail),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cart.title,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$ ${currentPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 15),
                ),
                Text(widget.cart.warrantyInformation),
              ],
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    currentIndex++;
                    currentPrice = widget.cart.price * currentIndex;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(4),

                  child: Icon(Icons.add, color: Colors.blue),
                ),
              ),
              Text(
                '$currentIndex',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      if (currentIndex > 1) {
                        setState(() {
                          currentIndex--;
                        });
                      } else {
                        context.read<CartCubit>().removeProduct(widget.cart);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.remove, color: Colors.blue),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
