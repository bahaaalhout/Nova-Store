import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key, required this.product});
  final ProductModel product;
  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          widget.product.images.isNotEmpty
              ? widget.product.images[currentindex]
              : widget.product.thumbnail,
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.67,
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: 80,
                alignment: Alignment.center,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.blue.withValues(alpha: 0.2),

                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.product.images.length,
                              itemBuilder: (context, index) {
                                bool isSelected = currentindex == index;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentindex = index;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 70,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      widget.product.images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Text(
                            "${currentindex + 1} / ${widget.product.images.length}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
