part of 'card_cubit.dart';

@immutable
sealed class CardState {}

final class CardInitial extends CardState {}

final class PurshaseCard extends CardState {
  final List purshasecard;

  PurshaseCard(this.purshasecard);
}

final class Wishlist extends CardState {
  final List purshasecard;

  Wishlist(this.purshasecard);
}
