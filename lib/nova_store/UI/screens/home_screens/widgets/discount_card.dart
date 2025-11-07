import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_state.dart';

import 'package:nova_store/nova_store/UI/screens/home_screens/product_screen.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key, required this.products});
  final ProductModel products;
  @override
  Widget build(BuildContext context) {
    var beforeDiscountPrice =
        products.price / (1 - products.discountPercentage / 100);

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductScreen(product: products),
        ),
      ),
      child: SizedBox(
        height: 240,
        width: 140,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      products.thumbnail,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          products.title,
                          style: TextStyle(color: Colors.black, fontSize: 17),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              '\$${products.price}',

                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            if (products.price < 999)
                              AutoSizeText(
                                '\$${beforeDiscountPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                        if (products.price > 999)
                          AutoSizeText(
                            '\$${beforeDiscountPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        Row(
                          children: [
                            Text(
                              '${products.rating} ★ ',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              '(${products.reviews.length})',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    height: 24,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: products.stock,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: const Radius.circular(12),
                                    bottomRight: Radius.zero,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 200 - products.stock,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.shade100,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: const Radius.circular(12),
                                    bottomLeft: Radius.zero,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: products.stock != 0
                              ? Text('🔥 ${products.stock} In Stock ')
                              : Text('Soled Out'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 23,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    '-${products.discountPercentage}%',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.withValues(alpha: 0.5),
                  foregroundColor: Colors.white,
                  child: BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, state) => IconButton(
                      onPressed: () {
                        var favoriteCubit = BlocProvider.of<FavoriteCubit>(
                          context,
                        );
                        if (favoriteCubit.isInFavorite(products)) {
                          favoriteCubit.removeProduct(products);
                        } else {
                          favoriteCubit.addProduct(products);
                        }
                      },
                      icon:
                          BlocProvider.of<FavoriteCubit>(
                            context,
                          ).isInFavorite(products)
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
