import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_cubit.dart';
import 'package:nova_store/nova_store/UI/provider/favorite_state.dart';
import 'package:nova_store/nova_store/UI/screens/favorite_screens/widgets/favorite_card.dart';
import 'package:nova_store/nova_store/UI/widgets/snack_bar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        List<ProductModel> favorite = [];
        if (state is OnSuccessState) {
          favorite = state.favorite;
        } else if (state is OnErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ShowSnackBar().snackBar(context, state.errorMesssage);
          });
        }

        return ListView.builder(
          itemCount: favorite.length,
          itemBuilder: (context, index) =>
              FavoriteCard(favorite: favorite[index]),
        );
      },
    );
  }
}
