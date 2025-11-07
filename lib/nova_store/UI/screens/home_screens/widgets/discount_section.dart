import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/product_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/product_state.dart';
import 'package:nova_store/nova_store/UI/screens/home_screens/widgets/discount_card.dart';

class DiscountSection extends StatelessWidget {
  const DiscountSection({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = 250;
    double peekWidth = 140;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 280,
          color: Color(0xffF0F7FA),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'Flash',
                  style: GoogleFonts.playwriteDeSas(
                    textStyle: TextStyle(
                      fontSize: 27,
                      color: Color(0xff65A296),
                    ),
                  ),
                ),
              ),
              Text(
                'SALE',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff2D5B55),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                color: Color(0xff65A296),
                child: Text(
                  'UP TO 70% OFF',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) => SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              padding: EdgeInsets.only(
                left: peekWidth,
                right: screenWidth - cardWidth,
              ),
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  state is OnLoadingState
                  ? Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 300,
                    )
                  : DiscountCard(products: products[index]),
            ),
          ),
        ),
      ],
    );
  }
}
