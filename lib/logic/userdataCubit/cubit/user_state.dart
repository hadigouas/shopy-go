part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class fetcheddata extends UserState {
  final Usermodule usermodule;

  fetcheddata({required this.usermodule});
}
