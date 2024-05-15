part of 'remove_cart_bloc.dart';

@immutable
abstract class RemoveCartState {}

class RemoveCartInitial extends RemoveCartState {}
class RemoveCartblocLoading extends RemoveCartState {}
class RemoveCartblocLoaded extends RemoveCartState {
}
class RemoveCartblocError extends RemoveCartState{}