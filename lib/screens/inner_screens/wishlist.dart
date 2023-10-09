import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce_app/logic/card_cubit/cubit/card_cubit.dart';
import 'package:ecommerce_app/logic/product_cubit/cubit/product_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/buyingcard.dart';
import 'package:ecommerce_app/widgets/empty_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class wishlist extends StatelessWidget {
  const wishlist({super.key});
  final bool _empty = false;
  @override
  Widget build(BuildContext context) {
    CardCubit _productCubit = BlocProvider.of<CardCubit>(context);

    return (_productCubit.wishlist.isEmpty)
        ? const emptycard(
            pic: 'images/card/bag_wish.png',
            title: 'the card is empty',
            text: 'please buy something to make me happy',
          )
        : Scaffold(
            body: DynamicHeightGridView(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              itemCount: _productCubit.wishlist.length,
              builder: (context, index) {
                return buyingcard(
                  productMod: ProductModule(
                      productImage: _productCubit.wishlist[index].productImage,
                      productQuantity: '',
                      productId: '',
                      productTitle: _productCubit.wishlist[index].productTitle,
                      productPrice: _productCubit.wishlist[index].productPrice,
                      productCategory: '',
                      productDescription: ''),
                );
              },
            ),
          );
  }
}
