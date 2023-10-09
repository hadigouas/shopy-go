import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/card_cubit/cubit/card_cubit.dart';
import 'package:ecommerce_app/logic/themebloc/cubit/themechange_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/bottomsheet.dart';
import 'package:ecommerce_app/widgets/mycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class fullcard extends StatelessWidget {
  const fullcard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);
    CardCubit _cardCubit = BlocProvider.of<CardCubit>(context);

    return Scaffold(
      bottomSheet: const bottomsheet(),
      appBar: AppBar(
        title: Shimmer.fromColors(
          baseColor: Colors.purple,
          highlightColor: Colors.red,
          child: const texts(
            text: 'shoppy go',
            middle: true,
          ),
        ),
        leading: Image.asset("images/profile/shopping-cart.png"),
        backgroundColor:
            theme.isdark == false ? Colors.grey[800] : Colors.white,
      ),
      body: ListView.builder(
        itemCount: _cardCubit.cardproducts.length,
        itemBuilder: (context, index) {
          return Mycard(
            index: index,
            productModule: ProductModule(
                productImage: _cardCubit.cardproducts[index].productImage,
                productQuantity: _cardCubit.cardproducts[index].productQuantity,
                productId: _cardCubit.cardproducts[index].productId,
                productTitle: _cardCubit.cardproducts[index].productTitle,
                productPrice: _cardCubit.cardproducts[index].productPrice,
                productCategory: '',
                productDescription: ''),
          );
        },
      ),
    );
  }
}
