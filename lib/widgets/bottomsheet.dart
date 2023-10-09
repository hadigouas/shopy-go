import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/card_cubit/cubit/card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class bottomsheet extends StatelessWidget {
  const bottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    CardCubit _cardCubit = BlocProvider.of<CardCubit>(context, listen: true);
    String mydouble = _cardCubit.totalprice.toStringAsFixed(2);
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                texts(
                  text: 'total(${_cardCubit.totalproducts})',
                  middle: true,
                ),
                texts(
                  text: '${mydouble}da',
                  color: Colors.blue,
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {}, child: const texts(text: 'checkout'))
          ],
        ),
      ),
    );
  }
}
