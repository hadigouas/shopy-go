part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class productmm extends ProductState {
  final List<ProductModule> productModule;

  productmm(this.productModule);
}

final class categoriepro extends ProductState {
  final List<ProductModule> productModule;

  categoriepro(this.productModule);
}

class Emptycategorie extends ProductState {}
