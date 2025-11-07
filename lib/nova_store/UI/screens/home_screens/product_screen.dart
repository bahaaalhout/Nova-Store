import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_state.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/image_display.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/product_bottom_bar.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, color: Colors.blue),
        ),
        actions: [
          BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) => IconButton(
              onPressed: () {
                if (favoriteCubit.isInFavorite(product)) {
                  favoriteCubit.removeProduct(product);
                } else {
                  favoriteCubit.addProduct(product);
                }
              },
              icon: favoriteCubit.isInFavorite(product)
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
      bottomSheet: ProductBottomBar(product: product),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageDisplay(product: product),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        product.title,
                        style: TextStyle(fontSize: 25),
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Text(
                          '(${product.rating})',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Availability: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      product.stock != 0
                          ? 'In Stock (${product.stock})'
                          : 'Out of Stock (0)',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ExpansionTile(
                title: Text(
                  'DESCRIPTION',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                backgroundColor: Colors.grey.shade100,
                childrenPadding: EdgeInsets.all(20),
                children: [Text(product.description)],
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '(${product.reviews.length})',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              for (var i in product.reviews)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            i.reviewerName!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Text('${i.rating!}'),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        i.reviewerEmail!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            i.comment!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            DateFormat(
                              'dd/MM/yyyy HH:mm',
                            ).format(DateTime.parse(i.date!)),
                          ),
                        ],
                      ),

                      Divider(),
                    ],
                  ),
                ),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
