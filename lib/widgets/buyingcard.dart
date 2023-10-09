import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/card_cubit/cubit/card_cubit.dart';
import 'package:ecommerce_app/logic/product_cubit/cubit/product_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/heart_button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class buyingcard extends StatelessWidget {
  const buyingcard({super.key, this.productMod});
  final ProductModule? productMod;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is productmm) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/discription',
                    arguments: productMod);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: productMod!.productImage,
                        height: size.height * 0.3,
                        width: size.width,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              texts(
                                text: productMod!.productTitle,
                                middle: true,
                              ),
                              texts(
                                text: '${productMod!.productPrice}',
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            heart(
                              productModule: productMod,
                              color: Colors.transparent,
                              size: 20,
                            ),
                            Material(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<CardCubit>(context)
                                      .addproduct(productMod!);
                                  BlocProvider.of<CardCubit>(context)
                                      .encrement(productMod!);
                                },
                                child: const Icon(
                                  Icons.check,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is categoriepro) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/discription',
                    arguments: productMod);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: productMod!.productImage,
                        height: size.height * 0.3,
                        width: size.width,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              texts(
                                text: productMod!.productTitle,
                                middle: true,
                              ),
                              texts(
                                text: '${productMod!.productPrice}',
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            heart(
                              color: Colors.transparent,
                              size: 20,
                              productModule: productMod,
                            ),
                            Material(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<CardCubit>(context)
                                      .addproduct(productMod!);
                                },
                                child: const Icon(
                                  Icons.check,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
