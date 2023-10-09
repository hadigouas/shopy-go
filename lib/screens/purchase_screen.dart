import 'package:ecommerce_app/logic/card_cubit/cubit/card_cubit.dart';
import 'package:ecommerce_app/widgets/empty_card.dart';
import 'package:ecommerce_app/widgets/full_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Purchase extends StatelessWidget {
  const Purchase({super.key});

  @override
  Widget build(BuildContext context) {
    CardCubit _cardCubit = BlocProvider.of<CardCubit>(context, listen: true);
    return _cardCubit.cardproducts.isEmpty
        ? const emptycard(
            pic: 'images/card/customer.png',
            title: 'the card is empty',
            text: 'please buy something to make me happy',
          )
        : const fullcard();
  }
}
