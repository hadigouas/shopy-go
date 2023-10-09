import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/themebloc/cubit/themechange_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/utils/reaction.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class discription extends StatelessWidget {
  const discription({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModule? productModule =
        ModalRoute.of(context)?.settings.arguments as ProductModule?;
    var size = MediaQuery.of(context).size;
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FancyShimmerImage(
                  width: size.width,
                  height: size.height * 0.4,
                  imageUrl: productModule!.productImage),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.6,
                      child: texts(
                        text: productModule!.productTitle,
                        big: true,
                        maxline: 2,
                        // Add ellipsis for long text
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    texts(
                      text: productModule!.productPrice,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              reaction(
                productModule: productModule,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  texts(
                    text: 'about this itme',
                    big: true,
                  ),
                  texts(text: productModule!.productCategory)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              texts(
                text: productModule!.productDescription,
                maxline: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}
