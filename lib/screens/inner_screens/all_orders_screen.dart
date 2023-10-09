import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/full_card.dart';
import 'package:ecommerce_app/widgets/mycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/card_cubit/cubit/card_cubit.dart';

class allorders extends StatelessWidget {
  const allorders({super.key});

  @override
  Widget build(BuildContext context) {
    CardCubit _cardCubit = BlocProvider.of<CardCubit>(context, listen: true);
    _cardCubit.cardproducts;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: texts(
          text: 'placed order',
          big: true,
        ),
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
