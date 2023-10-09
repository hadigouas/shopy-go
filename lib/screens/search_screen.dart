import 'package:ecommerce_app/consts/texts.dart';
import 'package:ecommerce_app/logic/product_cubit/cubit/product_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/buyingcard.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textcontroller = TextEditingController();
  @override
  void dispose() {
    _textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          BlocProvider.of<ProductCubit>(context).Myproduct();

          return false;
        },
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _textcontroller,
                      onChanged: (value) {
                        BlocProvider.of<ProductCubit>(context).filtered(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _textcontroller.clear();
                          },
                          icon: const Icon(Icons.delete_outlined),
                          color: Colors.red,
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                      )),
                ),
                Expanded(
                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state is productmm) {
                        return DynamicHeightGridView(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          itemCount: state.productModule.length,
                          builder: (context, index) {
                            return buyingcard(
                              productMod: ProductModule(
                                  productImage:
                                      state.productModule[index].productImage,
                                  productQuantity: state
                                      .productModule[index].productQuantity,
                                  productId: '',
                                  productTitle:
                                      state.productModule[index].productTitle,
                                  productPrice:
                                      state.productModule[index].productPrice,
                                  productCategory: state
                                      .productModule[index].productCategory,
                                  productDescription: state
                                      .productModule[index].productDescription),
                            );
                          },
                        );
                      } else if (state is categoriepro) {
                        return DynamicHeightGridView(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          itemCount: state.productModule.length,
                          builder: (context, index) {
                            return buyingcard(
                              productMod: ProductModule(
                                  productImage:
                                      state.productModule[index].productImage,
                                  productQuantity: '',
                                  productId: '',
                                  productTitle:
                                      state.productModule[index].productTitle,
                                  productPrice:
                                      state.productModule[index].productPrice,
                                  productCategory: state
                                      .productModule[index].productCategory,
                                  productDescription: state
                                      .productModule[index].productDescription),
                            );
                          },
                        );
                      } else if (state is Emptycategorie) {
                        return Center(
                          child: texts(text: 'there is no such products '),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
