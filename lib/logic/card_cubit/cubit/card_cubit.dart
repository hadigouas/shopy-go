import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());
  List<ProductModule> cardproducts = [];
  List<ProductModule> wishlist = [];

  double totalprice = 0;
  int totalproducts = 0;
  void addproduct(ProductModule productModule) {
    cardproducts.add(productModule);
    emit(PurshaseCard(cardproducts));
    print(cardproducts);
  }

  void deleteproduct(int index) {
    cardproducts.removeAt(index);

    emit(PurshaseCard(cardproducts));
    print(cardproducts);
  }

  void encrement(ProductModule productModule) {
    totalprice += double.parse(productModule.productPrice);
    totalproducts += 1;

    emit(PurshaseCard(cardproducts));
  }

  void decrement(ProductModule productModule) {
    totalprice -= double.parse(productModule.productPrice);
    totalproducts -= 1;

    emit(PurshaseCard(cardproducts));
  }

  void addtowishlist(ProductModule productModule) {
    wishlist.add(productModule);
    emit(Wishlist(wishlist));
  }
}
