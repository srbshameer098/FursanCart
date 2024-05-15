part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}
class AddToCartblocLoading extends AddToCartState {}
class AddToCartblocLoaded extends AddToCartState {
}
class AddToCartblocError extends AddToCartState{}