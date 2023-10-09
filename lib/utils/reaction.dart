import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/card_cubit/cubit/card_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/heart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class reaction extends StatelessWidget {
  reaction({super.key, required this.productModule});
  ProductModule productModule;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        heart(),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<CardCubit>(context).addproduct(productModule);
            BlocProvider.of<CardCubit>(context).encrement(productModule);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(12)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.check),
                texts(text: '  Purshase'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
