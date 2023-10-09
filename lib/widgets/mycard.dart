import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/card_cubit/cubit/card_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/heart_button.dart';
import 'package:ecommerce_app/widgets/quantity.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mycard extends StatelessWidget {
  Mycard({super.key, required this.index, required this.productModule});
  ProductModule productModule;
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    imageUrl: productModule.productImage,
                    width: 100,
                    height: 100,
                  ),
                ),
                Flexible(
                  child: texts(
                    text: productModule.productTitle,
                    maxline: 2,
                    middle: true,
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<CardCubit>(context)
                              .deleteproduct(index);
                          BlocProvider.of<CardCubit>(context)
                              .decrement(productModule);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    heart(
                      color: Colors.transparent,
                      size: 20,
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.blue)),
                  child: texts(
                      text: '${productModule.productPrice.toString()} Da'),
                ),
                InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (context) {
                        return const quantity();
                      },
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.black,
                        ),
                        texts(
                          text: productModule.productQuantity.toString(),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
